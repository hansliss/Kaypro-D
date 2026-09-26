# Source reconstruction status

## Confirmed milestone: routine symbols and structured helper routines

The current [reconstructed source](../src/D.asm) has been verified with NASM
against `reference/D.COM`: the assembled output is exactly 3552 bytes and has
no differing bytes.

Before the preceding milestone, the confirmed-string source was archived as
[`D-v3-confirmed-strings.asm`](../src/D-v3-confirmed-strings.asm). That archive
preserves the preceding state, in which the executable region was still
represented almost entirely by `db` statements.

Before this milestone, the routine-symbol version was archived as
[`D-v4-routine-symbols.asm`](../src/D-v4-routine-symbols.asm).

The immediately preceding four-routine version is archived as
[`D-v5-four-routines.asm`](../src/D-v5-four-routines.asm).

The preceding state for this package is archived as
[`D-v6-render-and-record.asm`](../src/D-v6-render-and-record.asm).

The current package began from that archive and is preserved in the working
history as [`D-v7-data-processing.asm`](../src/D-v7-data-processing.asm).

The current source adds stable symbols for the high-confidence code entry
points documented in `analysis/functions.md`. These are non-emitting aliases
where the surrounding listing remains byte-oriented, so adding names cannot
silently change offsets or omit bytes. The entry jump now names
`main_initialize_and_dispatch` while retaining its original encoding.

Three small routines at the end of the executable region are now expressed as
NASM instructions rather than raw bytes:

- `replace_leading_space_with_zero` (`0DAEh`)
- `bios_output_character` (`0DB8h`)
- `bios_output_marked_string` (`0DC8h`)

The final `0CDBh-0DDFh` area remains explicitly represented as reserved storage
(`sorted_record_storage`), with its exact length preserved.

Four additional routines are now expressed as instructions:

- `report_error` (`0B86h`)
- `wait_for_enter_or_abort` (`0BB2h`)
- `render_directory_screen` (`0BC2h`)
- `format_decimal_with_commas` (`0C41h`)

The next four conversions are also complete:

- `print_summary_totals` (`0B3Ch`)
- `render_left_entry` (`0C09h`)
- `render_right_entry` (`0C26h`)
- `format_directory_record` (`0C8Eh`)

The current package adds three data-processing routines:

- `ingest_dta_record` (`09F0h`)
- `insert_or_reject_sorted_record` (`0A64h`)
- `calculate_volume_totals` (`0AE3h`)

The ingestion routine now has named branches for directory classification,
character normalization, and unknown-character lookup. The sorter has named
labels for its record scan, insertion point, and copy/shift paths. These names
are local control-flow labels within confirmed routine boundaries.

The current package additionally converts:

- `enumerate_directory_entries` (`0788h`), including its DOS DTA setup and
  find-first/find-next calls; its final conditional branch remains connected
  to the surrounding fall-through path.
- `classify_command_character` (`0894h`)
- `delete_command_character` (`08BFh`)

The enumeration block is intentionally documented as a bounded entry block,
not as an independently returning routine, because its `JC` continuation at
`07B3h` falls into the surrounding main/path-processing flow.

## System-call annotation convention

The source now defines symbolic DOS and BIOS function numbers, such as
`DOS_FIND_FIRST`, `DOS_GET_FILE_ATTRIBUTES`, `DOS_GET_FREE_SPACE`,
`BIOS_SET_CURSOR`, and `BIOS_TTY_OUTPUT`. Converted interrupt sites use those
symbols and include short comments describing the observed input and output
registers. This keeps the service identity visible without changing any
instruction encoding.

The path-building block at `08D4h` is now converted through `0939h`. It copies
the command-tail/current-directory material into the search buffer, queries
attributes with DOS `AH=43h`, and appends the `\\*.*` suffix when the target is
a directory. Its separator and search-pattern targets are named separately;
the latter distinction is required by the original short-jump destinations.

The bounded main initialization block at `06F2h-0787h` is now converted. It
installs the Ctrl-C handler, saves the video and Ctrl-Break state, sizes the
record area, terminates and records the PSP command tail, saves the DOS DTA,
and establishes the current drive letter. The conversion uses symbolic DOS and
BIOS service names and preserves the original `xor`, `add`, and `sub` encodings
as `db` pairs where NASM would otherwise choose a different valid encoding.
The pre-conversion source is archived as
[`D-v9-system-annotated.asm`](../src/D-v9-system-annotated.asm).

The next bounded continuation, `07B3h-0893h`, is also converted. It handles
the end/continuation of the DOS directory search, copies and pads returned
names, obtains the current directory, removes recognized command-tail
characters, handles the `.`/`..` cases, and dispatches into the path builder.
Its calls to `classify_command_character` and `delete_command_character` are
now symbolic, while the existing fall-through into the path block remains
explicitly represented by shared labels.

The continuation at `093Ah-09EFh` is now converted as well. It copies the
drive/path prefix into the display buffer, performs the full-attribute
directory search, transfers the first and subsequent DTA records into sorted
storage, and enters the summary/display loop. The same block also contains the
Ctrl-Break handler: it clears the display, restores the saved Ctrl-Break state,
and terminates through DOS. Its BIOS/DOS calls use the established symbolic
service names. The pre-conversion source is archived as
[`D-v11-command-tail.asm`](../src/D-v11-command-tail.asm).

The remaining `db` statements have now been inventoried in
[`db-regions.md`](db-regions.md). No whole executable block remains as an
unexamined byte run: the remaining executable `db` statements are documented
alternate instruction encodings, while the other statements are text, tables,
mutable workspace, padding, or reserved record storage. The remaining semantic
work is therefore concentrated in the pre-code workspace map, especially
`041Dh-06BDh`, rather than in discovering a hidden code block.

The first workspace-label pass is complete. `src/D.asm` now marks `runtime_variables`
at `051Dh` and uses physical labels for the confirmed counters, pointers,
command-tail state, and formatter scratch fields in that block. Stable aliases
remain for later path buffers, character tables, and saved DOS state. A generic
PSP label is used for the read-only default-FCB drive byte at `005Ch`; no
stronger role is claimed for it. The pre-label source is archived as
[`D-v13-db-analysis.asm`](../src/D-v13-db-analysis.asm).

The runtime boundary is now sharper: `PROGRAM_DTA` begins at file `0435h` and
ends at `045Fh` (43 bytes), followed by a separately labeled
`DTA_ADJACENT_WORKSPACE` at `0460h`. This confirms that the directory count at
`0433h-0434h` is not a container for the following block.

All statically referenced addresses within the pre-code data area are now
physical labels in `src/D.asm`: the temporary record, insertion scratch word,
DTA fields, path-state/buffer objects, search-path state, record count, search
specification, character tables, mapping table, and size/date divisor. The
pre-label source is archived as
[`D-v16-referenced-data-labels.asm`](../src/D-v16-referenced-data-labels.asm).

The following formatting pass preserved the same labels and byte sequence while
compacting confirmed zero-only buffers with `times` expressions. The archived
pre-format source is [`D-v17-referenced-data-labels.asm`](../src/D-v17-referenced-data-labels.asm).
The current source also compacts the uniform blank spans in
`right_column_buffer`; the anomalous directory-row layout and small tables
remain explicit bytes. It assembles byte-for-byte to `reference/D.COM`.

The latest data-formatting pass is archived as
[`D-v19-right-column-times.asm`](../src/D-v19-right-column-times.asm). Uniform
buffers now use one `times` expression where possible, and repeated blank runs
within mixed buffers use `times` when they are at least four bytes long.

The final presentation pass moved all non-emitting constants to the file
header, reduced labels to code-accessed string/data entry points, normalized
short marked strings, and removed file-offset commentary. Buffer labels now
carry their load-address extents directly. These changes are editorial only;
the assembled bytes remain identical.

The former `03CDh-041Ch` ambiguity is resolved: `03CDh` is the marked terminator
for the continue/abort prompt, and `03CEh-041Ch` is the reusable two-column
directory-row buffer. The left and right field boundaries and their high-bit
terminators are now physical labels in the source. The pre-label source is
archived as [`D-v14-runtime-labels.asm`](../src/D-v14-runtime-labels.asm).

The original uses some valid alternative 8086 encodings for register-register
operations—for example `8B D8` for `mov bx,ax` where NASM normally emits
`89 C3`. Those cases use documented `db` pairs inside the otherwise mnemonic
routine, preserving both the original encoding and the semantic annotation.

## Final reconstruction state

The first access-map pass is now recorded in
[`workspace-access-map.md`](workspace-access-map.md). It covers the complete
pre-entry data area, separates observed CPU reads/writes from unobserved
bytes, and now includes explicit tracing of mocked DOS-side reads and writes.
The fixture suite now reaches 744 of 790 identified instruction starts
(94.18%); the single-dot and parent-directory cases validate the principal
command-tail special cases without changing the overall instruction union.

The current coverage-gap classification is recorded in
`simulation-results.md`. The remaining 46 instruction starts are now treated
as padding, alternate loop edges, unreferenced helpers, or unverified rare
formatting/error exits; they are not being forced through synthetic machine
state merely to inflate the coverage percentage.
The deep-nested-path and long-current-directory fixtures exercise
`current_search_path` through `06B7h` and `path_buffer` through `0670h`; the
single-dot and parent-directory fixtures validate the command-tail special
cases. Remaining untouched data is documented as workspace, padding, or
unverified trailing bytes rather than assigned speculative structures.

The reconstruction is complete at the byte level: `src/D.asm` assembles to
the exact `reference/D.COM` sequence. Further work would be optional semantic
refinement, not recovery of missing bytes or unresolved executable boundaries.
