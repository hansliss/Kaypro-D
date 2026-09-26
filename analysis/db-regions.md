# Remaining `db` regions and their status

This inventory describes why `src/D.asm` still contains `db` statements. It is
deliberate that the source remains byte-exact: replacing a `db` with a label or
data directive must not imply that its semantic boundary is more certain than
the evidence supports.

## Summary

There are no remaining unexamined executable blocks represented wholesale as
`db` statements. The executable region from load offset `06F2h` through the
end of the program is now expressed as instructions, except for individual
instruction encodings where NASM's preferred 8086 spelling emits a different
but equivalent byte sequence.

The remaining `db` statements fall into four categories:

1. confirmed text and display data;
2. initialized variables, mutable buffers, tables, and reserved workspace;
3. exact alternative instruction encodings inside documented code; and
4. the zero-filled sorted-record allocation tail.

## Data and workspace

| File range | Load range | Current interpretation | Confidence |
|---|---|---|---|
| `0003h-041Ch` | `0103h-051Ch` | Diagnostic records, fixed-width display templates, and the prompt/workspace area | Strong, with some internal field boundaries still being refined |
| `041Dh-0574h` | `051Dh-0674h` | Runtime words/bytes, counters, pointers, DTA-adjacent workspace, and blank capacity | Strong at individually referenced fields; weak for untouched gaps |
| `0575h-05BDh` | `0675h-06BDh` | Search-path/display buffers and mutable path state, including the initial `X:\` text | Strong |
| `05BEh-05EAh` | `06BEh-06EAh` | Default `X:\*.*` search specification and three character tables | Strong |
| `05EBh-05F1h` | `06EBh-06F1h` | Isolated initialized bytes immediately before the entry code | Exact bytes; semantic role unresolved |
| `0CDBh-0DDFh` | `0DDBh-0EDFh` | Zero-filled sorted-record/free-space allocation | Exact bytes and origin; runtime extent is calculated at startup |

The first range is already split into named printable strings and display
templates in `text-map.md`. The apparent blank areas are not safe to collapse
into one immutable data object: code writes counters, pointers, and formatting
results into them. The variable-level interpretation is recorded in
`variables.md`.

The source now marks the start of this runtime area with `runtime_variables`
and uses physical labels for the confirmed fields throughout the pre-code data
area: record capacity/end, next-record pointer, command-tail state, counts and
totals, display pointers, temporary/insertion records, DTA fields, path
buffers, table lengths, mapping data, and formatter scratch fields. Only PSP
locations and external allocation origins remain `equ` symbols. These labels
preserve the original absolute addresses.

The formatting pass archived as `src/D-v17-referenced-data-labels.asm` and
implemented in the current source now uses NASM `times` expressions for
zero-only buffers where their exact lengths are confirmed. This includes the
program DTA/workspace, DTA-adjacent workspace, temporary record, path buffer,
and the zero tail of the current search path. The uniform blank spans within
`right_column_buffer` are compacted similarly, while its separator and marker,
the anomalous `directory_row_buffer`, initialized tables, and individually
labeled fields remain explicit `db` statements so their byte values and
internal boundaries stay visible.

The subsequent normalization pass archived as
`src/D-v19-right-column-times.asm` combines adjacent `times` spans into one
expression for uniform buffers. It also compresses repeated blank runs of four
or more bytes inside mixed buffers, including the insertion/display workspace.
The anomalous row structure remains visible around its separator bytes.

## Alternative instruction encodings

These are not unknown bytes. Each is inside a confirmed code path, has been
decoded from the surrounding instruction stream, and is retained as `db` only
because the original uses the alternate 8086 register-register opcode. The
comments beside each statement give the intended mnemonic and identify the
original encoding.

| Code area | Typical preserved encodings | Reason retained as `db` |
|---|---|---|
| Main initialization and command/path processing | `33 D2`, `33 C0`, `03 F0`, `2B C6`, `8B FE`, `8B F7`, `32 FF`, `0B DB`, `33 C9`, `8A CC` | NASM selects equivalent ModR/M direction variants for several register operations |
| DTA ingestion | `8A E0`, `32 C0`, `8A C1` | Exact original register-transfer/xor encodings are preserved |
| Sorted-record insertion | `8B C1`, `03 C1`, `03 C8`, `8B F7` | Original register-register direction choices differ from NASM's normal output |
| Volume and summary arithmetic | `8A 16 BE 06`, `8B CA`, `8B FA`, `8B F0`, `8B C1`, `03 C7`, `8B D0`, `8B C6`, `32 C0`, `33 C9`, `33 D2` | Preserves both the original operand order encoding and absolute-address form |
| Decimal/date/time formatting | `8B D8`, `8B F2`, `03 F9`, `8B C6`, `8B C3`, `0B C6`, `8B D0`, `8B C8`, `0B C2`, `8B DA`, `8A C6`, `8A E1`, `8A D5`, `32 F6`, `0A FB`, `05 01 00` | These routines contain many original MASM/TASM-style register encodings |

The byte sequences are therefore semantically documented even though they are
not written with assembler mnemonics. Converting these to NASM instructions
would break exact reproduction unless the assembler's output is checked and
the raw form retained when it differs.

## Small data tables

The table region has direct code references and is no longer an undifferentiated
`db` block:

- `06C7h` is the length byte for the table at `06C8h`;
- `06C8h` contains separators/whitespace used by command-character scanning;
- `06D1h` is the length byte for the table at `06D2h`;
- `06D2h` contains the second command-character class;
- `06DAh` is the character-mapping table used by `XLAT` during filename
  normalization.

The exact table bytes remain `db` because they are data, not because their
boundaries are unknown.

## Remaining uncertainty

The file range `04BFh-05EDh` is a mixture of several referenced objects:

| File range | Load range | Working object | References/evidence |
|---|---|---|---|
| `04BFh-04D4h` | `05BFh-05D4h` | `temporary_record` | Written by `ingest_dta_record`; read by the sorted-record insertion routine and copied into record storage. |
| `04D7h-04D8h` | `05D7h-05D8h` | insertion destination scratch | Written while calculating an insertion position and read when copying the candidate record. |
| `052Ah-052Fh` | `062Ah-062Fh` | saved DTA segment/offset and saved video attribute | Startup saves DOS `ES:BX` and BIOS `AH`; the Ctrl-Break handler restores/uses this state. |
| `0533h-0534h` | `0633h-0634h` | path-state byte and mutable path buffer | The parent-directory path logic reads the state byte and edits the buffer. |
| `0575h-05B8h` | `0675h-06B8h` | normalized search path and end pointer | DOS attribute/search calls consume the path; construction writes the end pointer. |
| `05BCh-05BDh` | `06BCh-06BDh` | record count and adjacent state | Ingestion increments the count; insertion and display use it. |
| `05BEh-05EAh` | `06BEh-06EAh` | search specification and character tables | Search setup reads the wildcard specification; classifiers and `XLAT` read the three tables. |

The final bytes `05EBh-05EDh` (load `06EBh-06EDh`) are adjacent to the table
and immediately precede the isolated `05EEh-05F1h` bytes before code. No direct
reference to those trailing bytes has been found in the current source or
runtime access union, so they remain generic initialized/padding data rather
than being assigned a speculative variable name.

The only materially unresolved `db` semantics are within the pre-code mutable
workspace and the isolated `06EBh-06F1h` bytes. They are not currently read as
instructions by any confirmed path. The first CPU-side access map is recorded
in [`workspace-access-map.md`](workspace-access-map.md); it distinguishes
observed reads/writes from untouched capacity and documents the separate need
for DOS-service-level tracing. That combined map can tighten data labels
without risking an incorrect code conversion.
