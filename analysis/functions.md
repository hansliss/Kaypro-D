# D.COM preliminary function map

Names in this file are descriptive working names, not claims about original
symbol names. They are assigned only where the local instruction behavior is
clear. Addresses are COM load offsets, matching `reference/D-ndisasm.asm`.

## Confirmed or strongly supported routines

| Entry | Tentative name | Evidence and behavior | Confidence |
|---:|---|---|---|
| `06F2h` | `main_initialize_and_dispatch` | Sets interrupt/control state, computes available memory, parses the command tail, saves the DOS DTA, constructs the search path, and starts directory enumeration. | Strong |
| `0894h` | `classify_command_character` | Selects one of two character tables based on `AH`, scans it with `REPNE SCASB`, and returns status through flags; may retry with the alternate table when `AH` is zero. | Strong |
| `08BFh` | `delete_command_character` | Uses the length byte at `[SI-1]`, shifts the command-tail contents left with `REP MOVSB`, and decrements the stored length. | Strong |
| `0788h-07B3h` | `enumerate_directory_entries` | Installs the program DTA, calls DOS `INT 21h/AH=4Eh`, and repeatedly calls `AH=4Fh`; the following code copies/normalizes each returned entry. | Strong |
| `07B3h-0893h` | `process_command_tail_and_entry_name` | Continues directory enumeration, copies/pads the returned name, obtains the current directory, removes recognized command-tail characters, handles `.`/`..`, and falls through to path construction. | Strong |
| `093Ah-09EFh` | `process_directory_records_and_display` | Copies the path prefix, performs the full-attribute search, transfers DTA records into sorted storage, renders the summary/directory display, and contains the Ctrl-Break cleanup/termination path. | Strong |
| `09F0h` | `ingest_dta_record` | Reads the DTA attribute byte at `DTA+15h`, increments total/file counters, classifies directories, normalizes the 13-byte DOS name field, and copies size/date/time into a 22-byte temporary record. | Strong |
| `0A64h` | `insert_or_reject_sorted_record` | Compares the temporary record against existing records with a 13-byte `CMPSB` key, then shifts existing 22-byte records and inserts the new record at the selected position. | Strong |
| `0AE3h` | `calculate_volume_totals` | Positions the cursor, calls DOS `INT 21h/AH=36h`, performs sector/cluster arithmetic, and formats free/total byte quantities. | Strong |
| `0B3Ch` | `print_summary_totals` | Clears/positions the display and formats file count, directory count, and byte totals into the summary template. | Strong |
| `0B86h` | `report_error` | Selects an error message based on `AL`, prints it through the string-output routine, and returns to the caller or termination path. | Strong |
| `0BC2h` | `render_directory_screen` | Clears/configures the display with BIOS `INT 10h`, prints the directory heading, and iterates through screen rows/columns. | Strong |
| `0C09h` | `render_left_entry` | Clears a 37-byte field, converts/formats one internal directory record, prints it, and advances the output pointer/remaining-row count. | Strong |
| `0C26h` | `render_right_entry` | Same general operation as `render_left_entry`, for the second column. | Strong |
| `0C41h` | `format_decimal_with_commas` | Converts a 32-bit value in `DX:AX` to decimal text, inserts commas, right-aligns within a caller-supplied field, and preserves registers. | Strong |
| `0C8Eh` | `format_directory_record` | Initializes a fixed-width field, reads a record through the pointer at `[052Fh]`, converts the 8.3 name, and formats associated date/time/size information. | Strong |
| `0DAEh` | `replace_leading_space_with_zero` | Replaces a leading space at `[DI]` with ASCII `0`, used after numeric formatting. | Strong |
| `0DB8h` | `bios_output_character` | Outputs `AL` via BIOS video teletype `INT 10h/AH=0Eh`, masking the high bit. | Strong |
| `0DC8h` | `bios_output_marked_string` | Reads bytes from `CS:SI`, outputs the low seven bits through BIOS teletype, and stops after a byte with bit 7 set. | Strong |

## Preliminary control-flow observations

The first executable block at `06F2h` is a dispatcher/initialization path,
not merely a small startup stub. It establishes the environment before the
directory scan:

1. installs an interrupt vector/control-break-related handler;
2. obtains DOS state and saves the current DTA;
3. computes memory available for internal records;
4. normalizes the command tail;
5. builds a path/search specification;
6. invokes DOS directory enumeration;
7. collects, sorts, and displays records.

The path-processing code around `07D0h-093Ah` is not yet assigned a single
entry name because several blocks are reached by fall-through and local jumps.
The code clearly copies the current directory, appends separators where needed,
checks directory attributes with `INT 21h/AH=43h`, and appends `\\*.*` when the
specified path resolves to a directory.

## Direct call graph

This is a call graph of direct near calls observed in the executable. Local
jumps are documented in the canonical disassembly but are omitted here unless
they materially cross a routine boundary.

```text
main_initialize_and_dispatch (06F2)
├── classify_command_character (0894)
├── delete_command_character (08BF)
├── ingest_dta_record (09F0)
├── insert_or_reject_sorted_record (0A64)
├── print_summary_totals (0B3C)
├── calculate_volume_totals (0AE3)
├── render_directory_screen (0BC2)
└── wait_for_enter_or_abort (0BB2)

print_summary_totals (0B3C)
├── format_decimal_with_commas (0C41)
└── bios_output_marked_string (0DC8)

calculate_volume_totals (0AE3)
└── format_decimal_with_commas (0C41)

render_directory_screen (0BC2)
├── render_left_entry (0C09)
├── render_right_entry (0C26)
├── wait_for_enter_or_abort (0BB2)
└── bios_output_marked_string (0DC8)

render_left_entry / render_right_entry
├── format_directory_record (0C8E)
└── bios_output_marked_string (0DC8)

format_directory_record (0C8E)
├── format_decimal_with_commas (0C41)
└── replace_leading_space_with_zero (0DAE)

Formatting and date/time helpers
├── format_decimal_with_commas (0C41)
└── replace_leading_space_with_zero (0DAE)
```

The `0894h` and `08BFh` helpers are called repeatedly from the command-tail
normalization path. The path-building code around `08D4h-093Ah` is reached by
local control flow and is intentionally not presented as a single confirmed
subroutine yet.

## Internal record evidence

The insertion routine at `0A64h` shifts records by `16h` bytes while copying
`0Bh` words. This gives a strong record stride of **22 bytes**. The routine at
`09F0h` writes one such record beginning at the temporary-record pointer and
copies:

- one directory/file classification byte;
- a 13-byte normalized DOS name field;
- two words contributing to a 32-bit file size;
- one date word and one time word.

The exact character-mapping purpose of the normalized name and the precise
sort-key interpretation remain to be confirmed, but the DTA offsets and
22-byte record geometry are now strongly supported.

## Uncertainties retained deliberately

- `0894h` may classify command-tail characters rather than general characters;
  its table-scanning behavior is certain, but its caller-level purpose is still
  inferred.
- The exact entry point and boundaries of path parsing around `08D4h` are not
  yet stable.
- `0A64h` is described as sorting/insertion because of ordered `CMPSB` search
  and record shifting, but the precise sort key has not been isolated.
- The final termination/error paths after `0B86h` need separate tracing.
