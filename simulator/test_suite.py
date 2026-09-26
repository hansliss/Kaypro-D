#!/usr/bin/env python3
"""Fixture-driven behavioral probes for the D.COM simulation harness."""

from __future__ import annotations

import argparse
import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

from dos_harness import DirectoryEntry, Harness


@dataclass
class Scenario:
    name: str
    entries: list[DirectoryEntry]
    command_tail: str = ""
    current_directory: str = ""
    input_bytes: bytes = b"\r"
    require_records: bool = True
    initial_ax: int = 0
    psp_fcb_drive: int = 0
    psp_memory_limit: int = 0xF000
    expected_record_count: int | None = None


def scenarios() -> list[Scenario]:
    mapping_chars = ".!#$%&'()-^_`{}~"
    deep_path = "\\".join(["ABC"] * 14)
    long_current_directory = "\\".join(["ABC"] * 15)
    capacity_limit = 0xDDB + 10 * 0x16
    capacity_entries = lambda count: [DirectoryEntry(f"CAP{i:04d}.TXT", i)
                                      for i in range(count)]
    return [
        Scenario(
            "mixed-directory",
            [DirectoryEntry("ZETA.TXT", 7), DirectoryEntry("alpha.txt", 0),
             DirectoryEntry("DOCS", directory=True)],
        ),
        Scenario(
            "punctuation-and-case",
            [DirectoryEntry("A-B.TXT", 1), DirectoryEntry("A+B.TXT", 2),
             DirectoryEntry("a_b.txt", 3), DirectoryEntry("README.ME", 4)],
        ),
        Scenario(
            "size-extremes",
            [DirectoryEntry("EMPTY", 0), DirectoryEntry("BIG.BIN", 0xFFFFFFFF),
             DirectoryEntry("ONE.BIN", 1)],
        ),
        Scenario("empty-directory", [], require_records=False),
        Scenario(
            "nested-command-tail",
            [DirectoryEntry("INNER.TXT", 42, path="DOCS")],
            command_tail="DOCS\\*.TXT",
        ),
        Scenario(
            "pagination",
            [DirectoryEntry(f"FILE{i:02d}.TXT", i * 11) for i in range(20)],
            input_bytes=b"\r\r\r",
        ),
        Scenario("pagination-before-boundary", [
            DirectoryEntry(f"PRE{i:02d}.TXT", i) for i in range(14)
        ]),
        Scenario("pagination-at-boundary", [
            DirectoryEntry(f"AT{i:02d}.TXT", i) for i in range(15)
        ], input_bytes=b"\r"),
        Scenario("pagination-after-boundary", [
            DirectoryEntry(f"POST{i:02d}.TXT", i) for i in range(16)
        ], input_bytes=b"\r\r"),
        Scenario("no-match", [DirectoryEntry("INNER.TXT", 42, path="DOCS")],
                 command_tail="NOPE\\*.TXT", require_records=False),
        Scenario("invalid-path", [DirectoryEntry("ROOT.TXT", 42)],
                 command_tail="Z:\\NOPE\\*.TXT", require_records=False),
        Scenario("mapping-table", [
            DirectoryEntry(f"A{char}B.TXT", index)
            for index, char in enumerate(mapping_chars)
        ]),
        Scenario("volume-label", [
            DirectoryEntry("VOLUME", 0, attribute=0x08),
            DirectoryEntry("VISIBLE.TXT", 1),
        ]),
        # A non-empty tail is required here because the program's explicit-
        # drive path reuses and decrements the PSP command-tail length while
        # parsing.  An empty tail is not a valid DOS invocation state for this
        # branch: it underflows that byte and eventually destroys SEARCH_SPEC.
        Scenario("explicit-drive", [DirectoryEntry("DRIVE.TXT", 1)],
                 command_tail="C:\\DRIVE.TXT", psp_fcb_drive=3),
        Scenario("trailing-directory-slash", [
            DirectoryEntry("INNER.TXT", 42, path="DOCS")
        ], command_tail="DOCS\\", require_records=False),
        Scenario("deep-nested-path", [
            DirectoryEntry("INNER.TXT", 42, path=deep_path)
        ], command_tail=deep_path + "\\*.TXT"),
        Scenario("long-current-directory", [
            DirectoryEntry("INNER.TXT", 42, path=long_current_directory)
        ], current_directory=long_current_directory),
        Scenario("single-dot-command", [
            DirectoryEntry("INNER.TXT", 42, path="ABC")
        ], command_tail=".", current_directory="ABC"),
        Scenario("parent-directory-command", [
            DirectoryEntry("INNER.TXT", 42, path=".")
        ], command_tail="..\\*.TXT", current_directory="ABC"),
        Scenario("invalid-parent-directory", [], command_tail="..",
                 require_records=False),
        Scenario("directory-target", [
            DirectoryEntry("DOCS", directory=True)
        ], command_tail="DOCS", require_records=False),
        Scenario("control-c-pagination", [
            DirectoryEntry(f"ABORT{i:02d}.TXT", i) for i in range(20)
        ], input_bytes=b"\x03", require_records=False),
        Scenario("initial-error", [], initial_ax=0x00FF, require_records=False),
        Scenario("capacity-before", capacity_entries(9),
                 psp_memory_limit=capacity_limit, expected_record_count=9),
        Scenario("capacity-at", capacity_entries(10),
                 psp_memory_limit=capacity_limit, expected_record_count=10),
        Scenario("capacity-after", capacity_entries(11),
                 psp_memory_limit=capacity_limit, expected_record_count=10),
    ]


def run_scenario(root: Path, scenario: Scenario) -> tuple[dict[str, Any], Harness]:
    harness = Harness(
        root / "reference" / "D.COM",
        entries=scenario.entries,
        command_tail=scenario.command_tail,
        current_directory=scenario.current_directory,
        input_bytes=bytearray(scenario.input_bytes),
        initial_ax=scenario.initial_ax,
        psp_fcb_drive=scenario.psp_fcb_drive,
        psp_memory_limit=scenario.psp_memory_limit,
    )
    harness.run()
    report = harness.report()
    events = report["events"]
    snapshots = [e for e in events if e["kind"] == "sorted_records"]
    final_records = snapshots[-1]["records"] if snapshots else []
    output = report["output"]
    # Punctuation is intentionally allowed to become a control/mapping byte;
    # those cases are inspected through record snapshots rather than literal
    # screen-text matching.
    expected_count = (scenario.expected_record_count
                      if scenario.expected_record_count is not None
                      else len(scenario.entries))
    expected_names = [e.name.split(".", 1)[0].lower()
                      for e in scenario.entries[:expected_count]
                      if scenario.require_records and scenario.expected_record_count is None
                      and e.name.split(".", 1)[0].replace("_", "").isalnum()]
    missing_names = [name for name in expected_names if name not in output.lower()]
    assertions = {
        "terminated": report["terminated"],
        "has_dta_events": any(e["kind"] == "dta" for e in events)
        or not scenario.entries or not scenario.require_records,
        "has_record_snapshots": bool(snapshots) or any(e["kind"] == "temporary_record" for e in events) or not scenario.require_records,
        "expected_names_visible": not missing_names,
        "memory_fully_classified": not report["memory_coverage"]["unmapped_accesses"],
        "record_capacity_behavior": (scenario.expected_record_count is None
                                      or len(final_records) == scenario.expected_record_count),
    }
    if not all(assertions.values()):
        raise AssertionError({"scenario": scenario.name, "assertions": assertions,
                              "missing_names": missing_names})
    result = {
        "scenario": scenario.name,
        "fixture": {"command_tail": scenario.command_tail,
                     "entries": [asdict(e) for e in scenario.entries]},
        "assertions": assertions,
        "instructions": report["instructions"],
        "termination_code": report["termination_code"],
        "coverage": report["coverage"],
        "memory_coverage": report["memory_coverage"],
        "output": output,
        "final_sorted_records": final_records,
        "event_counts": {kind: sum(e["kind"] == kind for e in events)
                         for kind in sorted({e["kind"] for e in events})},
        "events": events,
    }
    return result, harness


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--log-dir", type=Path,
                        default=Path(__file__).with_name("logs"))
    parser.add_argument("--scenario", action="append",
                        help="run only this scenario; repeatable")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    selected = [s for s in scenarios() if not args.scenario or s.name in args.scenario]
    args.log_dir.mkdir(parents=True, exist_ok=True)
    summaries = []
    suite_executed: set[int] = set()
    suite_static: set[int] | None = None
    for scenario in selected:
        result, harness = run_scenario(root, scenario)
        suite_executed.update(harness.executed_addresses)
        suite_static = set(harness.static_code) if suite_static is None else suite_static
        log_path = args.log_dir / f"{scenario.name}.json"
        log_path.write_text(json.dumps(result, indent=2) + "\n")
        summaries.append({"scenario": scenario.name,
                          "instructions": result["instructions"],
                          "termination_code": result["termination_code"],
                          "event_counts": result["event_counts"],
                          "coverage": result["coverage"],
                          "memory_regions": result["memory_coverage"]["regions"],
                          "unmapped_accesses": result["memory_coverage"]["unmapped_accesses"],
                          "final_sorted_names": [r["name"] for r in result["final_sorted_records"]]})
    suite_covered = suite_executed & (suite_static or set())
    print(json.dumps({
        "passed": len(summaries),
        "suite_coverage": {
            "static_instruction_starts": len(suite_static or set()),
            "executed_instruction_starts": len(suite_covered),
            "percent": round(100 * len(suite_covered) / len(suite_static), 2)
                       if suite_static else None,
        },
        "scenarios": summaries,
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
