# D.COM preliminary memory map

## Scope and offset conventions

This is a preliminary map of `reference/D.COM`, based on the raw bytes, the
existing `ndisasm`/`objdump` output, recognizable text, and references made by
the executable code.

`D.COM` is a normal DOS `.COM` image. The first file byte is loaded at offset
`0100h`, so:

```text
COM load offset = file offset + 0100h
file offset     = COM load offset - 0100h
```

The existing disassemblies use COM load offsets. Hex dumps and `strings -t x`
use file offsets.

## Entry and major regions

| File offsets | COM load offsets | Tentative contents | Status |
|---|---:|---|---|
| `0000-0002` | `0100-0102` | Entry jump: `JMP 06F2h` | Confirmed code |
| `0003-041C` | `0103-051C` | Error messages and fixed-width directory-display text/templates | Strongly identified data |
| `041D-0574` | `051D-0674` | Sparse initialized variables, flags, counters, pointers, and reserved storage | Working model; individual fields still need annotation |
| `0575-05BD` | `0675-06BD` | Path/drive buffers and reserved storage; includes `X:\` | Strongly indicated data/workspace |
| `05BE-05EA` | `06BE-06EA` | Default search specification and character-class tables | Strongly identified data |
| `05EB-05F1` | `06EB-06F1` | Padding/isolated initialization bytes immediately before code | Uncertain |
| `05F2-0CDA` | `06F2-0DDA` | Executable code | Confirmed by entry jump and reachable control flow |
| `0CDB-0DDF` | `0DDB-0EDF` | Zero-filled tail / sorted-record allocation origin | Confirmed bytes; runtime role is record storage/free space |

The executable entry is therefore file offset `05F2h`, not the first byte of
the file. The bytes from `0003h` through `05F1h` are skipped by the initial
jump and must not be decoded as instructions without independent evidence.

Within the runtime area, `0433h-0434h` is the two-byte directory count. The
next range, `0435h-045Fh` (load `0535h-055Fh`), is the 43-byte DOS DTA installed
with `AH=1Ah`; it is not part of the count. The following `0460h-04B4h` range
is separate zero-initialized adjacent workspace, ending immediately before the
file-count field at `04B5h`.

## Identified text and display templates

The first data region contains CR/LF-terminated diagnostic messages including:

```text
< sub-dir >
Bad Path Name !
File not Found.
Path not found.
Too many open files (unable to open another one).
Insufficient memory.
Insufficient memory for text buffer (need 8k minimum).
Invalid Drive specified.
Invalid Directory Specification.
```

It then contains fixed-width output templates, including text recognizable as:

```text
Directory of
Dir's and Files Occupy
Bytes on Volume:
File .Ext KBytes mm-dd-yy hh:mm | File .Ext KBytes mm-dd-yy hh:mm
--------------------------------------|---------------------------------------
Bytes Free of                           Bytes Total
-------------------------------------------------------------------------------
==>      Continue =  CR                         Abort =  ^C
```

These templates contain large runs of spaces and punctuation. Their exact
field boundaries should be reconstructed from the formatting routines before
being treated as independent strings.

## Tables and small data objects

The bytes at file offset `05BEh` are especially clear:

```text
05BE  58 3A 5C 2A 2E 2A 00       "X:\\*.*", NUL
05C7  07 09 20 2B 2C 3A 3B 3D 0A 00
                                whitespace/separator character table candidate
05D1  08 22 2F 3C 3E 5B 5C 5D 7C 00
                                punctuation/special-character table candidate
05DB  2E 21 23 24 25 26 27 28 29 2D 5E 5F 60 7B 7D 7E 00
                                printable/special-character table candidate
```

The code scans the tables at load offsets `06C8h`, `06D2h`, and `06DAh`,
which correspond to file offsets `05C8h`, `05D2h`, and `05DAh`. The table
interpretation is therefore supported by executable references, although the
precise meaning of each table remains to be confirmed.

## Important caveat: data and workspace overlap

The pre-code area is not necessarily immutable data. Code writes to locations
inside the apparent template/storage region. For example, these load offsets
are used as variables or pointers by the executable:

| Load offset | File offset | Observed use |
|---:|---:|---|
| `051Dh` | `041Dh` | computed memory/layout value |
| `051Fh` | `041Fh` | computed value |
| `0521h` | `0421h` | current internal-record/storage pointer |
| `0525h` | `0425h` | saved DOS control-break state |
| `0526h-0529h` | `0426h-0429h` | command-line pointers/length-related values |
| `052Fh`, `0531h` | `042Fh`, `0431h` | output/storage pointers and counters |
| `05B5h-05BDh` | `04B5h-04BDh` | counts and byte totals |
| `05D7h` | `04D7h` | temporary insertion/storage pointer |
| `062Ah-062Ch` | `052Ah-052Ch` | saved original DOS DTA segment/offset |
| `0675h-06B8h` | `0575h-05B8h` | path/search buffers |
| `06BEh` | `05BEh` | drive/default-search area; also used as a variable |

This explains why a simple string/data scan cannot by itself produce exact
semantic boundaries. Some blank-padded objects are also mutable buffers, and
some zero-filled locations are variables initialized at run time.

## Confidence and next discriminating work

Confirmed:

- the entry jump and executable start at load offset `06F2h`;
- the presence and approximate extent of the text/templates;
- the default wildcard and character tables;
- the existence of code references into the apparent data/workspace area.

Still uncertain:

- exact field boundaries within the screen templates;
- which zero-filled locations are variables versus spare capacity;
- the complete internal directory-record layout;
- whether the template regions are copied, modified in place, or both.

The next useful step is to annotate each executable write and read of the
`04xxh-06xxh` load-offset range, then compare those accesses with the DOS DTA
record layout and the formatting routines.
