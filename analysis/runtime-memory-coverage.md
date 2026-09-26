# Runtime memory-access coverage

This document records the byte-level memory instrumentation added to the
Unicorn harness. It is an execution map: an address absent from the map was
not accessed by the selected fixture, not proof that the byte is unused in all
possible executions.

## Suite result

The current deterministic suite contains 26 scenarios. Across the suite's
union, 1,628 byte addresses were accessed. Every observed address is assigned to a
named region; there are no remaining `unmapped_or_external` accesses after the
COM stack was identified.

The union of accessed ranges is:

```text
0006-0007 005C 0080-008E
0103-0122 01D0-01E9 020C-04F5 04F7-0522 0525-0534
054A-055F 05B5-05D4 05D7-05D8 062A-062E 0633-0635
0675-0687 06B8-06B9 06BC-06BE 06C5-06EC
0DDB-0F92 FFE6-FFFD
```

These are observed address unions, not guessed object boundaries. The gap
between the static templates and the runtime fields remains meaningful: the
program reads some template bytes directly, but it does not touch every byte
of the pre-code region in these runs.

The harness now also records memory touched directly by mocked DOS services.
Those service-side accesses are kept separate from the CPU hook data because
the mock performs them outside emulated instructions. The detailed combined
workspace result is in [`workspace-access-map.md`](workspace-access-map.md);
notable additions are DOS writes to the DTA at `054Ah-055Fh`, the
get-current-directory write at `0634h-0670h`, and DOS reads of the
path/search strings at `0675h-06B7h` and `06BEh-06C4h`.

## Region interpretation

| Region | Observed extent or role | Evidence status |
|---|---|---|
| `psp` | `0006-0007`, `005C` | DOS COM startup fields read by the program |
| `psp_command_tail` | `0080-008E` in the current suite | command-tail length/text and parser mutations |
| `com_stack` | `FFE6-FFFD` | pushes/pops from the initial `SP=FFFE` |
| `static_data_or_workspace` | `0103-0122`, `01D0-04F5`, `04F7-0522`, `0525-0534` | mutable counters/pointers and formatting storage |
| `runtime_variables` | `051D-0534` broad area, with named fields and overlapping scratch/record views | named fields in `analysis/variables.md` |
| `program_dta` | `054A-055F` observed | DOS find-result fields; DTA base at `0535h` |
| `buffers_tables_or_static_data` | `05D7-05D8`, `062A-062E`, `0633-0635`, `0675-0687`, `06B8-06B9`, `06BC-06BE`, `06C5-06EC` | path buffers, tables, and counters |
| `temporary_record` | `05B5-05D4` overlaps surrounding variables | 22-byte candidate record and adjacent state |
| `sorted_record_storage_or_free_space` | `0DDB-0F92` for the exercised records | 22-byte records allocated from the computed storage base |

The harness reports overlapping semantic labels conservatively where a broad
region and a more specific variable range describe the same byte. The JSON
address map retains the raw read/write counts and instruction sites for each
byte.

## Important findings

The drive-specific parser is now exercised with a valid invocation. With an
empty command tail and a nonzero PSP FCB drive byte, the program's own helper
at `08BFh` decrements `[SI-1]`, underflowing the zero tail length and causing a
long `REP MOVSB` to overwrite the search specification. The resulting divide
fault at `0C54h` was therefore not treated as a missing emulator service.

The current coverage map validates the memory assumptions needed by the
simulator, but it does not yet prove that every byte in the full allocated
record area is semantically understood. The capacity boundary is covered
below; remaining work is to design fixtures for the remaining conditional
edges and the highest safe full-size record index.

## Capacity boundary

Startup computes the record capacity as:

```text
floor((word [PSP:0006] - 0x0DDB) / 0x16)
```

With the normal synthetic PSP limit `0xF000`, this is 2,631 22-byte slots,
ending at `0xEFF5`; the eleven-byte remainder remains below the PSP limit. A
full-size run is intentionally expensive because the original insertion sort
compares and shifts the accumulated record list. To isolate the boundary,
the harness accepts a configurable PSP memory limit and runs a 10-slot
equivalent boundary:

| Probe | Entries supplied | Entries stored | Remaining capacity |
|---|---:|---:|---:|
| `capacity-before` | 9 | 9 | 1 |
| `capacity-at` | 10 | 10 | 0 |
| `capacity-after` | 11 | 10 | 0 |

The capacity+1 probe confirms that enumeration stops at the computed limit;
the extra DTA result is not copied into sorted storage. This is observed
under a controlled PSP limit, while the arithmetic is the same as the normal
`0xF000` startup configuration.
