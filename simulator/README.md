# Basic D.COM simulation harness

`dos_harness.py` executes the original `reference/D.COM` in 16-bit mode and
provides a deterministic mock DOS/BIOS environment. It is intentionally small:
unsupported behavior raises an error rather than being guessed.

## Running

```sh
.venv/bin/python simulator/dos_harness.py
.venv/bin/python simulator/dos_harness.py --command-tail 'C:\\DOS\\*.COM'
.venv/bin/python simulator/dos_harness.py --json > trace.json
.venv/bin/python simulator/test_suite.py
```

The default fixture supplies three synthetic directory entries. The harness
records DOS/BIOS calls, DTA contents, writes to the temporary/sorted record
areas, marked-string output, and termination.

## Model boundaries

Implemented DOS services are the ones currently observed in the disassembly:

`25h`, `33h`, `2Fh`, `19h`, `1Ah`, `4Eh`, `4Fh`, `47h`, `43h`, `36h`, `07h`,
and `00h`.

Implemented BIOS video services are `08h`, `06h`, `02h`, and `0Eh`.

The CPU core is Unicorn in 16-bit x86 mode. The harness uses a flat emulated
memory segment with a synthetic PSP at offset zero and loads the COM image at
`0100h`. This matches the program's segment-relative assumptions for the
current binary, but is not a general DOS memory manager.

Each report contains instruction-start coverage against the executable region
identified in the raw disassembly, conditional-branch edge counts, and a
byte-level read/write map. The memory map distinguishes PSP, command tail,
COM stack, runtime variables, DTA, temporary records, tables/buffers, and
sorted-record storage. Accesses outside those named regions are reported as
unmapped instead of being silently ignored.

## Trace interpretation

- `dos`: interrupt site and register state before the mocked service returns;
- `service_memory_accesses`: memory reads/writes performed directly by mocked
  DOS services, including DTA population and path/search-string consumption;
- `bios`: interrupt site and register state;
- `dta`: synthetic find-result written to the program DTA;
- `record_write`: writes into the temporary or sorted-record areas;
- `output`: one BIOS teletype character;
- `terminate`: DOS termination observed.

The fake DTA uses the standard offsets documented in
`analysis/dos-calls.md`. New unsupported calls or CPU/emulator failures should
be treated as evidence about the program's actual execution path, not hidden
by expanding the mock speculatively.

## Fixture suite

`test_suite.py` runs 26 deterministic cases for mixed files/directories, case
and punctuation normalization, size extremes, empty directories, nested and
explicit-drive command tails, trailing directory separators, pagination
boundaries, Ctrl-C abort, no-match and invalid paths, volume labels, initial
error state, long current directories, `.`/`..` command cases, directory
targets, and the special-character mapping table. Each scenario writes a
complete JSON event log under `simulator/logs/` and prints a compact summary.
The suite asserts termination, DTA activity, record snapshots, and visibility
of fixture names. It also reports conditional branch edges and memory regions
used by each execution, plus the union of instruction starts reached by the
whole suite.

The explicit-drive fixture uses a valid `C:\\DRIVE.TXT` command tail. An empty
tail is intentionally not used for that branch: the original parser decrements
the PSP tail-length byte while consuming drive-specific syntax, and an empty
tail underflows it into the search buffer. That is recorded as a program
precondition, not hidden by the harness.
