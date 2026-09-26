# D.COM text and display-constant map

Addresses below are file offsets unless explicitly marked as COM load offsets.
The corresponding load offset is file offset plus `0100h`.

This map separates exact byte ranges from semantic interpretations. A range
can be exact even when its use is still uncertain.

## Diagnostic records

The first data block is a sequence of diagnostic records. The recognizable
message text is bounded by the surrounding CR/LF-like bytes and the next
record; the `8Ah` byte is significant because the marked-string routine masks
the high bit for output and uses it as a record terminator.

| File range | Length | Recognizable text | Status |
|---|---:|---|---|
| `0003-0011` | `0Fh` | `< sub-dir >` | Exact record; includes control/marker bytes |
| `0012-0024` | `13h` | `Bad Path Name !` | Exact record; includes control/marker bytes |
| `0025-0037` | `13h` | `File not Found.` | Exact record; includes control/marker bytes |
| `0038-004A` | `13h` | `Path not found.` | Exact record; includes control/marker bytes |
| `004B-007F` | `35h` | `Too many open files (unable to open another one).` | Exact record; includes control/marker bytes |
| `0080-0097` | `18h` | `Insufficient memory.` | Exact record; includes control/marker bytes |
| `0098-00CF` | `38h` | `Insufficient memory for text buffer (need 8k minimum).` | Exact record; includes control/marker bytes |
| `00D0-00E9` | `1Ah` | `Invalid Drive specified.` | Exact record; marker is followed immediately by next text |
| `00EA-010B` | `22h` | `Invalid Directory Specification.` | Exact record; ends immediately before the header template |

These are byte ranges, not yet all confirmed individual call arguments. The
error dispatcher at `0B86h` selects among them using `AL`; call-site tracing
will supply the final symbolic names and selection table.

## Fixed-width display templates

The following ranges are exact because their starts are visible in the raw
data and their ends are established by the next template boundary. They are
not NUL-terminated strings. Their padding is part of the output layout.

| File range | Length | Visible role |
|---|---:|---|
| `010C-015B` | `50h` | directory heading and first line terminator |
| `015C-01AC` | `51h` | directory/file/volume summary line |
| `01AD-01FD` | `51h` | equals-sign separator |
| `01FE-024D` | `50h` | two-column file heading |
| `024E-029E` | `51h` | two-column dashed separator |
| `029F-02EF` | `51h` | equals-sign separator before totals |
| `02F0-0338` | `49h` | free/total-bytes summary template |
| `0339-0389` | `51h` | final dashed separator |
| `038A-03CD` | `44h` | continue/abort prompt |
| `03CE-041C` | `4Fh` | mutable two-column directory-row buffer: left field, separator spacing, right field, and marked-string terminator |

The `010C-015B` header is used through the formatting path that scans a
`50h`-byte area. Other templates are consumed by fixed offsets in the summary
and rendering routines, but those call-site relationships still need to be
written into the source comments.

## Source conversion status

The current `src/D.asm` converts all 18 confirmed printable runs in the tables
above to labelled NASM `db "..."` declarations. It also labels the confirmed
CR/LF entry points used by the error dispatcher, such as
`file_not_found_prefix` and `path_not_found_prefix`. Their surrounding
control, marker, and padding bytes remain explicit `db` values. This preserves
the distinction between a confirmed printable run and a larger logical record
whose consumer has not yet been fully reconstructed.

The code at load `0CF2h` copies exactly `0Bh` bytes from load `0105h`,
independently confirming the length of `subdir_text`.

## Remaining text questions

## Encoding interpretation from call sites

The apparent CR/LF irregularities are explained by two consumers sharing the
same byte pool:

1. `bios_output_marked_string` at `0DC8h` reads bytes with `CS:LODSB`, masks
   bit 7 for display, and stops after the byte whose bit 7 is set.
2. Other code copies fixed byte counts, such as the 11 bytes copied from load
   `0105h` by the directory-record formatter.

Thus `0D 8A` is an encoded CR/LF followed by a marked-string terminator: the
LF is displayed as `0A`, then the high bit ends that marked string. A following
`0D 0A` is normally the CR/LF prefix of the next adjacent message, not a
second terminator belonging to the preceding message. That is why some visible
strings appear to be followed by both `0D 8A` and another `0D 0A`.

The error dispatcher confirms the pointer convention. For example, it selects
load `0123h` for the “File not Found.” message, which is the CR/LF prefix before
the printable text at file `0025h` / load `0125h`. Other error pointers use the
same arrangement. The default error pointer at load `0110h` begins at the
earlier CR/LF prefix before “Bad Path Name !” at file `0012h` / load `0112h`.

The first `< sub-dir >` record illustrates the mixed use particularly well:
the marked-string loop at `0BE1h` starts at load `0103h` and emits the leading
CR/LF before stopping at `8Ah`, while the directory formatter separately
copies the printable 11-byte text from load `0105h`.

The unmarked `0A` bytes therefore do not indicate a failed terminator. They are
literal LF bytes in adjacent CR/LF prefixes or fixed-format data. The `A0h`
byte in the prompt area is another example of the same high-bit convention: it
displays as a space and terminates the marked string.

- The visible text starts reported by `strings` are reliable navigation aids,
  but are not by themselves object boundaries.
- The `8Ah` and `A0h` high-bit bytes need to be represented by named encoding
  constants only after all marked-string consumers are checked.
- The `03CE-041C` area is a mutable two-column directory-row buffer. The left
  formatter clears 37 bytes beginning at load `04CFh` (file `03CFh`) and emits
  from load `04CEh`; it writes the high-bit terminator `FCh` at file `03F5h`.
  The right formatter clears 37 bytes beginning at load `04F7h` (file
  `03F7h`) and emits from there; the final `A0h` at file `041Ch` terminates the
  marked string. The source labels this as `directory_row_buffer`, with
  `left_column_end_marker`, `right_column_buffer`, and
  `right_column_end_marker` sublabels.
- The next conversion should handle the diagnostic records one at a time,
  with a rebuild and byte comparison after each group.
