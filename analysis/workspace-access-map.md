# Mutable workspace access map

This map summarizes the current static interpretation and the union of the
twenty deterministic simulator scenarios. Addresses in this document are COM
load offsets. The main pre-code workspace begins at load `051Dh` (file offset
`041Dh`); the map extends through load `06F1h` (file offset `05F1h`) so that
the complete initialized pre-entry data area is represented.

The simulator records CPU-side memory reads and writes, plus explicit memory
accesses made by mocked DOS services. An address absent from the combined
observed union is not thereby proven unused in every possible execution.

## Access summary

Across the suite, 162 of the 469 bytes in `051Dh-06F1h` were accessed by the
CPU. Mocked DOS services add service-side accesses, bringing the combined
union to 262 bytes. The CPU-only categories are:

```text
read-only:  054A-055F 0634-0635 0676-0677 0687 06C7-06EA 06EC
write-only: 051D-0520 0528-052A 05B9-05BA 062A-062D 06B8-06B9
read/write: 0521-0522 0525-0527 052B-0534 05B5-05B8 05BB-05D4
            05D7-05D8 062E 0633 0675 0678-0686 06BC-06BE
            06C5-06C6 06EB
```

The currently unobserved bytes are:

```text
0523-0524 0535-0549 0560-05B4 05D5-05D6 05D9-0629
062F-0632 0670-0674 06BA-06BB 06BF-06C4 06ED-06F1
```

After combining CPU and service-side accesses, the observed categories are:

```text
read-only:  0676-0677 06B7 06BF-06C4 06C7-06EA 06EC
write-only: 051D-0520 0528-052A 05B9-05BA 062A-062D 06B8-06B9
read/write: 0521-0522 0525-0527 052B-0534 054A-055F 05B5-05B8
            05BB-05D4 05D7-05D8 062E 0633-066F 0675 0678-06B7
            06BC-06BE 06C5-06C6 06EB
```

The remaining combined-unobserved bytes are:

```text
0523-0524 0535-0549 0560-05B4 05D5-05D6 05D9-0629
062F-0632 0636-0674 06BA-06BB 06ED-06F1
```

## Service-side access evidence

The new service instrumentation records these ranges across the suite:

| Range | Service operation | Interpretation |
|---|---|---|
| `054Ah-055Fh` | DOS find (`AH=4Eh/4Fh`) writes DTA attribute, time, date, size, and name | Confirms the standard 43-byte DTA field layout used by the program |
| `0634h-0670h` | DOS get-current-directory (`AH=47h`) writes a long current directory in the long-current-directory fixture | Confirms most of `path_buffer` is a DOS path destination |
| `0675h-06B7h` | DOS path-attribute/search calls read strings in the deep-path fixture | Confirms `current_search_path` is consumed through its full 67-byte extent as a NUL-terminated path/search specification |
| `06BEh-06C4h` | DOS find (`AH=4Eh`) reads the wildcard specification | Confirms the initialized `X:\\*.*` object is externally consumed, not merely static padding |

These accesses are recorded separately from Unicorn CPU hooks because the mock
service performs them through direct memory operations.

## Region-level interpretation

| Load range | Working object | Static role | Suite observation |
|---|---|---|---|
| `051Dh-0534h` | runtime variables | capacities, pointers, command-tail state, formatter state, and counts | 22/24 bytes accessed; `0523h-0524h` remain untouched |
| `0535h-055Fh` | program DTA | DOS find-result structure installed with `AH=1Ah` | DOS writes `054Ah-055Fh`; the program reads the corresponding fields, while the leading DTA bytes remain untouched |
| `0560h-05B4h` | DTA-adjacent workspace | zero-initialized storage following the 43-byte DTA | entirely untouched by the suite |
| `05B5h-05BEh` | counts and search-specification prefix | file/record counts, totals, and the first search-specification byte | all bytes accessed; count fields are read/written, most initialization bytes are written before use |
| `05BFh-05D6h` | temporary record | 22-byte candidate record populated from the DTA and sorted | 22/24 bytes accessed; `05D5h-05D6h` are the unobserved tail bytes |
| `05D7h-0629h` | insertion/display workspace | insertion pointer followed by the static two-column display template | only insertion pointer `05D7h-05D8h` accessed by the suite; template bytes are not dynamically read in these paths |
| `062Ah-0632h` | saved DOS/video state | saved DTA segment/offset, video attribute, and adjacent initialized bytes | `062Ah-062Dh` written, `062Eh` read/written; `062Fh-0632h` untouched |
| `0633h-0674h` | path state and path buffer | mutable path-state byte and zero-filled path construction buffer | state byte is CPU-read/written; DOS writes through `0670h`; `0670h-0674h` remains unobserved |
| `0675h-06B7h` | current search path | current drive/path text and mutable path tail | The deep nested-path fixture reaches the full buffer through `06B7h` |
| `06B8h-06BDh` | path end pointer and record count | path construction result and enumerated-record count | end pointer is write-only; record count is read/written; `06BAh-06BBh` untouched |
| `06BEh-06F1h` | search specification, tables, and trailing bytes | wildcard specification, separators, special-character table, mapping table, and isolated bytes before code | `06BEh` and the table area are accessed; `06BFh-06C4h` and `06EDh-06F1h` remain unobserved |

## Conclusions

The access map supports the existing semantic boundaries. In particular:

- `program_dta` is a real 43-byte DOS structure: DOS writes its meaningful
  fields and the program consumes them, while the leading reserved bytes are
  untouched;
- `dta_adjacent_workspace` is confirmed as a distinct, currently untouched
  zero-filled area rather than part of the DTA or the count variables;
- the temporary record is used as a 22-byte object, although its final two
  bytes were not reached by the current scenarios;
- the insertion pointer is live, while the following display-template bytes
  have not yet been shown to participate in an executed path;
- the path-buffer tail at `0670h-0674h` and the trailing bytes at `06EDh-06F1h`
  remain unobserved, while the full current-search-path buffer is now exercised.

The next analysis should design minimal fixtures for the unobserved conditional
paths and buffer ranges. Until then, the unobserved spans should remain named
data or reserved workspace, not be collapsed into speculative structures.
