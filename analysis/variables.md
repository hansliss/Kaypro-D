# D.COM preliminary variable and storage map

Addresses are COM load offsets. File offsets are 100h lower. Entries are
classified by the strongest current evidence; a name is a working name only.

## Runtime state and DOS integration

The runtime-variable area begins at load offset `051Dh` (file offset `041Dh`),
marked as `runtime_variables` in `src/D.asm`. The names below are working
symbols for storage locations, not claims about original source identifiers.

| Load offset | Size | Working name | Evidence |
|---:|---:|---|---|
| `051Dh` | word | `record_storage_end` | Computed from available memory and the 22-byte record stride. |
| `051Fh` | word | `record_capacity_bytes` | Product of record count and 22-byte stride. |
| `0521h` | word | `next_record_pointer` | Advanced by `16h` after each accepted record and used as the insertion destination. |
| `0525h` | byte | `saved_ctrl_break_state` | Receives `DL` from DOS `AH=33h, AL=00h` and is restored later. |
| `0526h` | word | `command_tail_end` | Stores the pointer after the command-tail text. |
| `0528h` | byte | `command_tail_length` | Derived from the command-tail pointer difference. |
| `0529h` | word | `command_tail_start` | Set to load offset `0081h`. |
| `052Ah` | word | `saved_dta_segment` | Receives `ES` from DOS `AH=2Fh`. |
| `052Ch` | word | `saved_dta_offset` | Receives `BX` from DOS `AH=2Fh`. |
| `062Eh` | byte | `saved_video_attribute` | Receives the attribute from BIOS `INT 10h/AH=08h`. |
| `005Ch` | byte | `PSP_DEFAULT_FCB_DRIVE` | Read during startup and path construction as the PSP default-FCB drive byte; retained as a generic PSP label because the program does not write it. |
| `0080h-0081h` | byte/string | `PSP_COMMAND_TAIL_LENGTH` / `PSP_COMMAND_TAIL_TEXT` | DOS PSP command-tail length and text, normalized in place during startup. |
| `0675h-06B8h` | buffer | `normalized_search_path` | Used by `AH=43h` and `AH=4Eh`; receives the current path and wildcard. |
| `06BEh` | buffer/byte | `search_specification` | Initially contains `X:\*.*`; its first byte is also updated with the selected drive letter. |
| `06C7h` | byte | `separator_table_length` | Read by the character-classification helper. |
| `06C8h` | table | `separator_table` | Scanned by `0894h` when `AH != 2`. |
| `06D1h` | byte | `special_table_length` | Read by the character-classification helper. |
| `06D2h` | table | `special_table` | Scanned by `0894h` when `AH == 2`. |
| `06DAh` | table | `character_mapping_table` | Used by `XLAT` during name normalization. |

## DTA and record storage

| Load offset | Size | Working name | Evidence |
|---:|---:|---|---|
| `0535h-055Fh` | 43 bytes | `program_dta` | Installed with DOS `AH=1Ah`; standard find-result fields occur at `+15h`, `+16h`, `+18h`, `+1Ah`, and `+1Eh`. |
| `0560h-05B4h` | 85 bytes | `dta_adjacent_workspace` | Separate zero-initialized workspace between the 43-byte DTA and the file/count variables; no independent semantic object is established yet. |
| `05BFh-05D4h` | 22 bytes | `temporary_record` | Filled by `09F0h` and used as the sort/insertion candidate. |
| `0DDBh` onward | 22-byte records | `sorted_record_storage` | Record copies begin here; the storage end is calculated at startup. |
| `05B5h` | word | `file_count` | Incremented for each accepted non-directory file. |
| `05B7h` | word | `remaining_record_capacity` | Initialized from available memory and decremented during enumeration. |
| `05B9h` | word | `record_capacity` | Initial computed count derived from available memory. |
| `05BBh-05BDh` | dword | `total_bytes` | Accumulated from DTA size words and formatted in the summary. |
| `0533h` | word | `directory_count` | Incremented when the DTA attribute has bit `10h`; formatted in the summary. |
| `06BCh` | word | `record_count` | Incremented during DTA ingestion and used by insertion/screen rendering. |
| `06C5h` | word | `comparison_pointer` | Temporary pointer used while scanning sorted records. |
| `06CFh` | word | `sectors_or_cluster_scale` | Divisor used by date/time or size formatting; precise role needs further tracing. |
| `05D7h` | word | `insertion_destination_pointer` | Computed insertion destination used when copying the temporary record. |
| `0633h` | byte | `path_state_byte` | Read by the parent-directory handling path logic. |
| `0634h` onward | buffer | `path_buffer` | Mutable current-directory/path construction buffer. |

## Formatting scratch fields

These fields are clearly variables but are not part of the persistent record
model:

| Load offset | Working name | Evidence |
|---:|---|---|
| `052Bh` | `format_field_state` | Decimal formatter's digit/separator countdown. |
| `052Ch` | `format_record_attribute` | Temporary record attribute copied while formatting a display row. |
| `052Dh` | `format_record_pointer` | Saved destination pointer while a formatted record is assembled. |
| `06B8h` | `search_path_end_pointer` | End pointer written after path construction and consumed by later path/display logic. |

## Remaining ambiguity

The `04xxh-05xxh` region contains both initialized bytes and blank-padded
templates. Some entries above are established by direct reads/writes; others
are names assigned from their surrounding arithmetic. The next useful check is
to trace every access to `0521h`, `052Fh`, `0531h`, `05B5h-05BDh`, and `06BCh`
through the enumeration and rendering loops.
