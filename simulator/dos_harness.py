#!/usr/bin/env python3
"""Minimal, deterministic DOS/BIOS harness for reference/D.COM.

This is intentionally a harness, not a DOS replacement. It executes the
original 16-bit COM image with Unicorn and emulates only the interrupt
services observed in the current disassembly. Unsupported services fail
loudly so that new reverse-engineering evidence can extend the model.
"""

from __future__ import annotations

import argparse
import fnmatch
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from unicorn import (Uc, UcError, UC_ARCH_X86, UC_HOOK_CODE, UC_HOOK_INTR,
                     UC_HOOK_MEM_READ, UC_HOOK_MEM_WRITE, UC_MODE_16)
from unicorn.x86_const import (
    UC_X86_REG_AH, UC_X86_REG_AL, UC_X86_REG_AX, UC_X86_REG_BH,
    UC_X86_REG_BL, UC_X86_REG_BX, UC_X86_REG_CH, UC_X86_REG_CL,
    UC_X86_REG_CX, UC_X86_REG_DH, UC_X86_REG_DI, UC_X86_REG_DL,
    UC_X86_REG_DX, UC_X86_REG_DS, UC_X86_REG_ES, UC_X86_REG_IP,
    UC_X86_REG_SI, UC_X86_REG_SP, UC_X86_REG_EFLAGS,
)


MEMORY_SIZE = 0x100000
COM_LOAD = 0x100
DTA = 0x535
SEARCH_SPEC = 0x6BE
TEMP_RECORD = 0x5BF
RECORD_STORAGE = 0xDDB
TRACE_POINTS = {0x6F2, 0x788, 0x964, 0x96F, 0x984, 0x9F0, 0xA64, 0xBC2}


@dataclass
class DirectoryEntry:
    name: str
    size: int = 0
    date: int = 0x4A21
    time: int = 0x7C00
    directory: bool = False
    path: str = "."
    attribute: int | None = None

    def write_to_dta(self, memory: Uc) -> None:
        """Write the standard DOS find-result fields into the program DTA."""
        attr = self.attribute if self.attribute is not None else (0x10 if self.directory else 0x00)
        memory.mem_write(DTA + 0x15, bytes([attr]))
        memory.mem_write(DTA + 0x16, self.time.to_bytes(2, "little"))
        memory.mem_write(DTA + 0x18, self.date.to_bytes(2, "little"))
        memory.mem_write(DTA + 0x1A, self.size.to_bytes(4, "little"))
        encoded = self.name.upper().encode("ascii", "replace")[:12] + b"\0"
        memory.mem_write(DTA + 0x1E, encoded.ljust(13, b"\0"))


@dataclass
class Harness:
    image_path: Path
    entries: list[DirectoryEntry] = field(default_factory=list)
    command_tail: str = ""
    current_directory: str = ""
    input_bytes: bytearray = field(default_factory=lambda: bytearray(b"\r"))
    initial_ax: int = 0
    psp_fcb_drive: int = 0
    psp_memory_limit: int = 0xF000
    trace_instructions: bool = False
    capture_record_snapshots: bool = True
    capture_record_writes: bool = True
    capture_memory_accesses: bool = True
    capture_code_trace: bool = True
    max_instructions: int = 2_000_000
    events: list[dict[str, Any]] = field(default_factory=list)
    output: bytearray = field(default_factory=bytearray)
    instruction_count: int = 0
    search_index: int = -1
    vectors: dict[int, tuple[int, int]] = field(default_factory=dict)
    current_dta: tuple[int, int] = (0, DTA)
    terminated: bool = False
    termination_code: int | None = None
    executed_addresses: set[int] = field(default_factory=set)
    active_entries: list[DirectoryEntry] = field(default_factory=list)
    previous_address: int | None = None
    memory_accesses: dict[int, dict[str, Any]] = field(default_factory=dict)
    service_memory_accesses: dict[int, dict[str, Any]] = field(default_factory=dict)

    def __post_init__(self) -> None:
        self.uc = Uc(UC_ARCH_X86, UC_MODE_16)
        self.uc.mem_map(0, MEMORY_SIZE)
        image = self.image_path.read_bytes()
        self.uc.mem_write(COM_LOAD, image)
        self._initialize_psp()
        self.uc.hook_add(UC_HOOK_INTR, self._on_interrupt)
        if self.capture_code_trace:
            self.uc.hook_add(UC_HOOK_CODE, self._on_code)
        if self.capture_memory_accesses:
            self.uc.hook_add(UC_HOOK_MEM_READ, self._on_read)
            self.uc.hook_add(UC_HOOK_MEM_WRITE, self._on_write)
        self.static_code, self.static_branches = self._load_static_metadata()

    def _load_static_metadata(self) -> tuple[set[int], dict[int, dict[str, Any]]]:
        """Load instruction starts and conditional branches from the raw listing."""
        listing = self.image_path.parent.parent / "reference" / "D-ndisasm.asm"
        result: set[int] = set()
        branches: dict[int, dict[str, Any]] = {}
        if not listing.exists():
            return result, branches
        for line in listing.read_text().splitlines():
            match = re.match(r"^([0-9A-Fa-f]+)\s+([0-9A-Fa-f]+)\s+(.*)$", line)
            if not match:
                continue
            address = int(match.group(1), 16)
            if not 0x6F2 <= address < 0xDDB:
                continue
            result.add(address)
            text = match.group(3)
            mnemonic = text.split()[0].lower()
            if (mnemonic.startswith("j") and mnemonic != "jmp") or mnemonic.startswith("loop"):
                target_match = re.search(r"0x([0-9a-f]+)", text, re.IGNORECASE)
                if target_match:
                    branches[address] = {
                        "mnemonic": mnemonic,
                        "target": int(target_match.group(1), 16),
                        "fallthrough": address + len(match.group(2)) // 2,
                        "taken": 0,
                        "not_taken": 0,
                    }
        return result, branches

    def _initialize_psp(self) -> None:
        # COM programs enter with all relevant segments equal to the PSP
        # segment. Offset 0006h is used by D.COM as its available-memory limit.
        self.uc.mem_write(0x0006, self.psp_memory_limit.to_bytes(2, "little"))
        tail = self.command_tail.encode("ascii", "replace")[:126]
        self.uc.mem_write(0x80, bytes([len(tail)]) + tail.ljust(127, b"\0"))
        self.uc.mem_write(0x5C, bytes([self.psp_fcb_drive]))
        self.uc.reg_write(UC_X86_REG_DS, 0)
        self.uc.reg_write(UC_X86_REG_ES, 0)
        self.uc.reg_write(UC_X86_REG_SP, 0xFFFE)
        self.uc.reg_write(UC_X86_REG_AX, self.initial_ax)
        self.uc.reg_write(UC_X86_REG_IP, COM_LOAD)

    def reg(self, name: int) -> int:
        return self.uc.reg_read(name)

    def _snapshot_regs(self) -> dict[str, int]:
        return {
            "ax": self.reg(UC_X86_REG_AX), "bx": self.reg(UC_X86_REG_BX),
            "cx": self.reg(UC_X86_REG_CX), "dx": self.reg(UC_X86_REG_DX),
            "si": self.reg(UC_X86_REG_SI), "di": self.reg(UC_X86_REG_DI),
            "ip": self.reg(UC_X86_REG_IP), "sp": self.reg(UC_X86_REG_SP),
        }

    def _read_word(self, address: int) -> int:
        return int.from_bytes(self.uc.mem_read(address, 2), "little")

    def _decode_record(self, address: int) -> dict[str, Any]:
        raw = bytes(self.uc.mem_read(address, 0x16))
        name = raw[1:14].split(b"\0", 1)[0].decode("ascii", "replace")
        return {
            "address": f"{address:04X}",
            "classification": raw[0],
            "name_bytes": raw[1:14].hex(),
            "name": name,
            "size": int.from_bytes(raw[14:18], "little"),
            "date": int.from_bytes(raw[18:20], "little"),
            "time": int.from_bytes(raw[20:22], "little"),
        }

    def _snapshot_records(self, kind: str) -> None:
        count = min(self._read_word(0x6BC), 256)
        records = [self._decode_record(RECORD_STORAGE + i * 0x16) for i in range(count)]
        self.event(kind, count=count, records=records,
                   next_record_pointer=f"{self._read_word(0x521):04X}")

    def event(self, kind: str, **values: Any) -> None:
        self.events.append({"kind": kind, **values})

    def _set_cf(self, value: bool) -> None:
        flags = self.uc.reg_read(UC_X86_REG_EFLAGS)
        flags = (flags | 1) if value else (flags & ~1)
        self.uc.reg_write(UC_X86_REG_EFLAGS, flags)

    def _set_dta_result(self, entry: DirectoryEntry) -> None:
        entry.write_to_dta(self.uc)
        # These writes are performed by DOS, outside the emulated CPU, so the
        # Unicorn memory-write hook cannot observe them.
        self._track_service_memory("write", DTA + 0x15, 1, "INT21/AH=4E/4F DTA attribute")
        self._track_service_memory("write", DTA + 0x16, 2, "INT21/AH=4E/4F DTA time")
        self._track_service_memory("write", DTA + 0x18, 2, "INT21/AH=4E/4F DTA date")
        self._track_service_memory("write", DTA + 0x1A, 4, "INT21/AH=4E/4F DTA size")
        self._track_service_memory("write", DTA + 0x1E, 13, "INT21/AH=4E/4F DTA name")
        self.event("dta", index=self.search_index, name=entry.name,
                   directory=entry.directory, size=entry.size,
                   date=entry.date, time=entry.time,
                   bytes=self.uc.mem_read(DTA + 0x15, 0x1A).hex())

    def _read_string(self, address: int, service: str) -> str:
        raw = bytearray()
        for offset in range(260):
            value = self.uc.mem_read(address + offset, 1)[0]
            self._track_service_memory("read", address + offset, 1, service)
            if value == 0:
                break
            raw.append(value)
        return raw.decode("ascii", "replace")

    @staticmethod
    def _normalize_path(path: str) -> str:
        path = path.replace("/", "\\").upper()
        path = re.sub(r"^[A-Z]:", "", path).strip("\\")
        return path or "."

    def _matching_entries(self, specification: str) -> list[DirectoryEntry]:
        spec = re.sub(r"^[A-Za-z]:", "", specification.replace("/", "\\"))
        spec = spec.lstrip("\\")
        directory, _, pattern = spec.rpartition("\\")
        directory = self._normalize_path(directory)
        pattern = pattern or "*.*"
        if pattern == "*.*":
            pattern = "*"
        return [entry for entry in self.entries
                if self._normalize_path(entry.path) == directory
                and fnmatch.fnmatchcase(entry.name.upper(), pattern.upper())]

    def _dos(self) -> None:
        ah, al = self.reg(UC_X86_REG_AH), self.reg(UC_X86_REG_AL)
        site = self.reg(UC_X86_REG_IP) - 2
        self.event("dos", site=f"{site:04X}", ah=ah, al=al,
                   regs=self._snapshot_regs())

        if ah == 0x25:
            self.vectors[al] = (self.reg(UC_X86_REG_DS), self.reg(UC_X86_REG_DX))
        elif ah == 0x33 and al == 0:
            self.uc.reg_write(UC_X86_REG_DL, 1)
        elif ah == 0x33 and al == 1:
            pass
        elif ah == 0x2F:
            self.uc.reg_write(UC_X86_REG_ES, self.current_dta[0])
            self.uc.reg_write(UC_X86_REG_BX, self.current_dta[1])
        elif ah == 0x19:
            self.uc.reg_write(UC_X86_REG_AL, 2)  # synthetic C: drive
        elif ah == 0x1A:
            self.current_dta = (self.reg(UC_X86_REG_DS), self.reg(UC_X86_REG_DX))
        elif ah in (0x4E, 0x4F):
            if ah == 0x4E:
                self.search_index = 0
                specification = self._read_string(self.reg(UC_X86_REG_DX),
                                                   "INT21/AH=4E search specification")
                self.active_entries = self._matching_entries(specification)
                self.event("find_specification", specification=specification,
                           matches=[entry.name for entry in self.active_entries])
            else:
                self.search_index += 1
            if self.search_index < len(self.active_entries):
                self._set_dta_result(self.active_entries[self.search_index])
                self._set_cf(False)
            else:
                self.uc.reg_write(UC_X86_REG_AX, 0x0012)
                self._set_cf(True)
                self.event("find_end", function=ah)
        elif ah == 0x47:
            # DOS AH=47h uses DS:SI for the destination; DL selects the drive.
            address = self.reg(UC_X86_REG_SI)
            directory = self.current_directory.strip("\\")
            payload = (directory.encode("ascii", "replace") if directory
                       else b"\\") + b"\0"
            self.uc.mem_write(address, payload)
            self._track_service_memory("write", address, len(payload),
                                       "INT21/AH=47 current directory")
        elif ah == 0x43 and al == 0:
            path = self._normalize_path(self._read_string(
                self.reg(UC_X86_REG_DX), "INT21/AH=43 path"))
            found = next((entry for entry in self.entries
                          if self._normalize_path(entry.path + "\\" + entry.name) == path), None)
            self.uc.reg_write(UC_X86_REG_CX, 0x10 if found and found.directory else 0)
            self._set_cf(found is None)
        elif ah == 0x36:
            # sectors/cluster, bytes/sector, free clusters, total clusters
            self.uc.reg_write(UC_X86_REG_AX, 8)
            self.uc.reg_write(UC_X86_REG_BX, 1000)
            self.uc.reg_write(UC_X86_REG_CX, 512)
            self.uc.reg_write(UC_X86_REG_DX, 2000)
        elif ah == 0x07:
            value = self.input_bytes.pop(0) if self.input_bytes else 0x0D
            self.uc.reg_write(UC_X86_REG_AL, value)
        elif ah == 0x00:
            self.terminated = True
            self.termination_code = self.reg(UC_X86_REG_AL)
            self.event("terminate", code=self.termination_code)
            self.uc.emu_stop()
        else:
            raise RuntimeError(f"unsupported DOS INT 21h AH={ah:02X} at {site:04X}")

    def _bios(self) -> None:
        ah, al = self.reg(UC_X86_REG_AH), self.reg(UC_X86_REG_AL)
        site = self.reg(UC_X86_REG_IP) - 2
        self.event("bios", site=f"{site:04X}", ah=ah, al=al,
                   regs=self._snapshot_regs())
        if ah == 0x08:
            self.uc.reg_write(UC_X86_REG_AL, 0)
            self.uc.reg_write(UC_X86_REG_AH, 0x07)
        elif ah == 0x06:
            pass
        elif ah == 0x02:
            pass
        elif ah == 0x0E:
            self.output.append(al & 0x7F)
            self.event("output", char=al & 0x7F)
        else:
            raise RuntimeError(f"unsupported BIOS INT 10h AH={ah:02X} at {site:04X}")

    def _on_interrupt(self, uc: Uc, intno: int, _user_data: Any) -> None:
        if intno == 0x21:
            self._dos()
        elif intno == 0x10:
            self._bios()
        else:
            raise RuntimeError(f"unsupported interrupt {intno:02X} at {self.reg(UC_X86_REG_IP)-2:04X}")

    def _on_code(self, _uc: Uc, address: int, size: int, _user_data: Any) -> None:
        if self.previous_address in self.static_branches:
            branch = self.static_branches[self.previous_address]
            if address == branch["target"]:
                branch["taken"] += 1
            elif address == branch["fallthrough"]:
                branch["not_taken"] += 1
        self.previous_address = address
        self.instruction_count += 1
        self.executed_addresses.add(address)
        if self.instruction_count > self.max_instructions:
            raise RuntimeError("instruction limit exceeded")
        if self.trace_instructions or address in TRACE_POINTS:
            self.event("instruction", address=f"{address:04X}", size=size,
                       regs=self._snapshot_regs())
        if self.capture_record_snapshots and address == 0xA64:
            self.event("temporary_record", record=self._decode_record(TEMP_RECORD))
        elif self.capture_record_snapshots and address == 0x964:
            self.event("temporary_record", record=self._decode_record(TEMP_RECORD))
        elif self.capture_record_snapshots and address == 0x96F:
            self._snapshot_records("sorted_records")
        elif self.capture_record_snapshots and address == 0x984:
            self._snapshot_records("sorted_records")

    @staticmethod
    def _memory_region(address: int) -> str:
        if 0x80 <= address < 0x100:
            return "psp_command_tail"
        if 0 <= address < 0x100:
            return "psp"
        if 0xF000 <= address < 0x10000:
            return "com_stack"
        if 0x6F2 <= address < 0xDDB:
            return "code"
        if 0x535 <= address < 0x561:
            return "program_dta"
        if 0x5BF <= address < 0x5D5:
            return "temporary_record"
        if 0xDDB <= address < 0xF000:
            return "sorted_record_storage_or_free_space"
        if 0x51D <= address < 0x575:
            return "runtime_variables"
        if 0x575 <= address < 0x6F2:
            return "buffers_tables_or_static_data"
        if 0x100 <= address < 0x6F2:
            return "static_data_or_workspace"
        return "unmapped_or_external"

    def _track_memory(self, kind: str, address: int, size: int) -> None:
        for offset in range(size):
            slot = self.memory_accesses.setdefault(address + offset,
                                                   {"read": 0, "write": 0,
                                                    "regions": set(), "sites": set()})
            slot[kind] += 1
            slot["regions"].add(self._memory_region(address + offset))
            slot["sites"].add(self.reg(UC_X86_REG_IP))

    def _track_service_memory(self, kind: str, address: int, size: int,
                              service: str) -> None:
        for offset in range(size):
            slot = self.service_memory_accesses.setdefault(
                address + offset,
                {"read": 0, "write": 0, "services": set()})
            slot[kind] += 1
            slot["services"].add(service)

    def _on_read(self, _uc: Uc, _access: int, address: int, size: int,
                 _value: int, _user_data: Any) -> None:
        self._track_memory("read", address, size)

    def _on_write(self, _uc: Uc, _access: int, address: int, size: int, value: int, _user_data: Any) -> None:
        self._track_memory("write", address, size)
        if self.capture_record_writes and (TEMP_RECORD <= address < TEMP_RECORD + 0x16 or
                                           RECORD_STORAGE <= address < RECORD_STORAGE + 0x100):
            self.event("record_write", address=f"{address:04X}", size=size,
                       value=value)

    def run(self) -> None:
        try:
            self.uc.emu_start(COM_LOAD, MEMORY_SIZE)
        except UcError as exc:
            raise RuntimeError(f"CPU emulation stopped at {self.reg(UC_X86_REG_IP):04X}: {exc}") from exc

    def report(self) -> dict[str, Any]:
        unexecuted = sorted(self.static_code - self.executed_addresses)
        ranges: list[list[str]] = []
        for address in unexecuted:
            # Group nearby unexecuted instruction starts. The display is a
            # navigation aid, not a claim that every byte in the interval is
            # an instruction boundary.
            if ranges and address <= int(ranges[-1][1], 16) + 4:
                ranges[-1][1] = f"{address:04X}"
            else:
                ranges.append([f"{address:04X}", f"{address:04X}"])
        return {
            "instructions": self.instruction_count,
            "terminated": self.terminated,
            "termination_code": self.termination_code,
            "output": self.output.decode("ascii", "replace"),
            "coverage": {
                "static_instruction_starts": len(self.static_code),
                "executed_instruction_starts": len(self.executed_addresses & self.static_code),
                "unexecuted_instruction_starts": len(unexecuted),
                "percent": round(100 * len(self.executed_addresses & self.static_code) /
                                 len(self.static_code), 2) if self.static_code else None,
                "unexecuted_ranges": ranges,
                "conditional_branches": {
                    "total": len(self.static_branches),
                    "covered": sum(bool(branch["taken"] or branch["not_taken"])
                                    for branch in self.static_branches.values()),
                    "both_edges": sum(bool(branch["taken"] and branch["not_taken"])
                                      for branch in self.static_branches.values()),
                },
            },
            "branch_coverage": {
                f"{address:04X}": value
                for address, value in self.static_branches.items()
            },
            "memory_coverage": {
                "accessed_addresses": len(self.memory_accesses),
                "regions": {
                    region: sum(region in slot["regions"]
                                for slot in self.memory_accesses.values())
                    for region in sorted({region for slot in self.memory_accesses.values()
                                          for region in slot["regions"]})
                },
                "unmapped_accesses": [f"{address:04X}"
                                      for address, slot in sorted(self.memory_accesses.items())
                                      if "unmapped_or_external" in slot["regions"]],
                "addresses": {
                    f"{address:04X}": {
                        "read": slot["read"], "write": slot["write"],
                        "regions": sorted(slot["regions"]),
                        "sites": [f"{site:04X}" for site in sorted(slot["sites"])],
                    }
                    for address, slot in sorted(self.memory_accesses.items())
                },
                "service_addresses": {
                    f"{address:04X}": {
                        "read": slot["read"], "write": slot["write"],
                        "services": sorted(slot["services"]),
                    }
                    for address, slot in sorted(self.service_memory_accesses.items())
                },
            },
            "events": self.events,
        }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--command-tail", default="", help="synthetic PSP command tail")
    parser.add_argument("--trace-instructions", action="store_true")
    parser.add_argument("--json", action="store_true", help="emit structured trace JSON")
    parser.add_argument("--max-instructions", type=int, default=2_000_000)
    args = parser.parse_args()
    harness = Harness(
        Path(__file__).resolve().parents[1] / "reference" / "D.COM",
        entries=[
            DirectoryEntry("README.TXT", size=1234),
            DirectoryEntry("TOOLS.BIN", size=98765),
            DirectoryEntry("DOCS", directory=True),
        ],
        command_tail=args.command_tail,
        trace_instructions=args.trace_instructions,
        max_instructions=args.max_instructions,
    )
    harness.run()
    report = harness.report()
    if args.json:
        print(json.dumps(report, indent=2))
    else:
        print(f"instructions: {report['instructions']}")
        print(f"terminated: {report['terminated']} code={report['termination_code']}")
        print("output:")
        print(report["output"])
        print(f"events: {len(report['events'])}")
        for event in report["events"]:
            if event["kind"] in {"dos", "dta", "find_end", "record_write", "terminate"}:
                print(json.dumps(event, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
