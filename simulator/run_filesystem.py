#!/usr/bin/env python3
"""Run D.COM against a simplified DOS view of a Unix directory.

The CPU and DOS service implementation come from ``dos_harness.Harness``.
This front end deliberately turns off tracing, coverage collection, and event
logging; its only user-visible output is the emulated program's screen text.

The mounted directory is presented as drive C:.  Only ordinary directories
and regular files are imported.  Symlinks, device nodes, sockets, FIFOs, and
Unix names that cannot be represented by a simple DOS 8.3 name are skipped.
"""

from __future__ import annotations

import argparse
import datetime as dt
import os
import re
import sys
from pathlib import Path

from dos_harness import DirectoryEntry, Harness
from unicorn.x86_const import (UC_X86_REG_AH, UC_X86_REG_AL, UC_X86_REG_CH,
                               UC_X86_REG_CL, UC_X86_REG_DH, UC_X86_REG_DL)


DOS_NAME_RE = re.compile(r"^[A-Z0-9$%'-_@~`!(){}^#&]+(?:\.[A-Z0-9$%'-_@~`!(){}^#&]+)?$")


def dos_name(name: str) -> str | None:
    """Return a conservative uppercase 8.3 representation, or ``None``."""
    if name in {".", ".."} or not name.isascii():
        return None
    upper = name.upper()
    parts = upper.split(".")
    if len(parts) > 2 or not parts[0] or len(parts[0]) > 8:
        return None
    if len(parts) == 2 and (not parts[1] or len(parts[1]) > 3):
        return None
    if not DOS_NAME_RE.fullmatch(upper):
        return None
    return upper


def dos_datetime(timestamp: float) -> tuple[int, int]:
    """Convert Unix local time to the packed DOS date and time fields."""
    value = dt.datetime.fromtimestamp(timestamp)
    year = min(max(value.year, 1980), 2107)
    date = ((year - 1980) << 9) | (value.month << 5) | value.day
    time = (value.hour << 11) | (value.minute << 5) | (value.second // 2)
    return date, time


def import_filesystem(root: Path) -> list[DirectoryEntry]:
    """Build recursive DOS directory entries from ``root``.

    ``os.scandir`` plus ``follow_symlinks=False`` keeps the imported tree
    bounded by the selected root and avoids treating links as real DOS files.
    Entries are sorted to make runs reproducible for a given filesystem state.
    """
    entries: list[DirectoryEntry] = []
    pending = [(root, ".")]
    while pending:
        directory, relative = pending.pop()
        children: list[tuple[str, os.DirEntry[str]]] = []
        with os.scandir(directory) as scan:
            for child in scan:
                children.append((child.name.upper(), child))
        for _, child in sorted(children):
            name = dos_name(child.name)
            if name is None:
                continue
            try:
                info = child.stat(follow_symlinks=False)
            except OSError:
                continue
            child_path = "." if relative == "." else relative
            if child.is_dir(follow_symlinks=False):
                date, time = dos_datetime(info.st_mtime)
                entries.append(DirectoryEntry(
                    name=name, directory=True, path=child_path,
                    date=date, time=time,
                ))
                next_relative = name if relative == "." else f"{relative}\\{name}"
                pending.append((Path(child.path), next_relative))
            elif child.is_file(follow_symlinks=False):
                date, time = dos_datetime(info.st_mtime)
                entries.append(DirectoryEntry(
                    name=name, size=min(info.st_size, 0xFFFFFFFF),
                    path=child_path, date=date, time=time,
                ))
    return entries


class QuietFilesystemHarness(Harness):
    """The existing emulator with all diagnostic collection disabled."""

    def _load_static_metadata(self) -> tuple[set[int], dict[int, dict[str, object]]]:
        return set(), {}

    def event(self, _kind: str, **_values: object) -> None:
        pass


class AnsiFilesystemHarness(QuietFilesystemHarness):
    """Quiet harness whose BIOS screen operations become ANSI controls."""

    def _bios(self) -> None:
        ah = self.reg(UC_X86_REG_AH)
        if ah == 0x02:
            row = self.reg(UC_X86_REG_DH)
            column = self.reg(UC_X86_REG_DL)
            self.output.extend(f"\x1b[{row + 1};{column + 1}H".encode("ascii"))
        elif ah == 0x06 and self.reg(UC_X86_REG_AL) == 0:
            # D.COM uses AH=06h, AL=00h to clear rectangular display windows.
            # Keep the listing visible in this demonstration mode: reposition
            # to the window's upper-left corner instead of erasing the screen.
            row = self.reg(UC_X86_REG_CH)
            column = self.reg(UC_X86_REG_CL)
            self.output.extend(f"\x1b[{row + 1};{column + 1}H".encode("ascii"))
        else:
            super()._bios()


def run(root: Path, command_tail: str, current_directory: str = "",
        ansi: bool = True) -> str:
    entries = import_filesystem(root)
    harness_type = AnsiFilesystemHarness if ansi else QuietFilesystemHarness
    harness = harness_type(
        Path(__file__).resolve().parents[1] / "reference" / "D.COM",
        entries=entries,
        command_tail=command_tail,
        current_directory=current_directory,
        trace_instructions=False,
        capture_record_snapshots=False,
        capture_record_writes=False,
        capture_memory_accesses=False,
        capture_code_trace=False,
    )
    harness.run()
    if not harness.terminated:
        raise RuntimeError("D.COM stopped without DOS termination")
    return harness.output.decode("ascii", "replace").rstrip("\x00")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path,
                        help="Unix directory mounted as emulated C:\\")
    parser.add_argument("--command-tail", default="",
                        help="DOS command tail (default: current C: directory)")
    parser.add_argument("--current-directory", default="",
                        help="DOS current directory relative to the mount")
    parser.add_argument("--plain", action="store_true",
                        help="emit the linear teletype stream without ANSI controls")
    args = parser.parse_args()
    root = args.directory.resolve()
    if not root.is_dir():
        parser.error(f"not a directory: {root}")
    try:
        sys.stdout.write(run(root, args.command_tail, args.current_directory,
                             ansi=not args.plain))
    except (OSError, RuntimeError) as exc:
        print(f"D.COM simulation failed: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
