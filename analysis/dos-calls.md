# D.COM DOS and BIOS call inventory

Addresses are COM load offsets, matching the annotated disassembly. Register
values shown immediately before an interrupt are the values established by the
local code path; values not shown are not assumed.

## DOS `INT 21h` calls

| Site | Function | Register setup / observed purpose |
|---:|---|---|
| `0702h` | `AH=25h` set interrupt vector | `AL=23h`, `DS:DX=CS:09C4h`; installs the program's Ctrl-C/Ctrl-Break-related handler. The exact vector semantics should be verified against DOS documentation. |
| `0713h` | `AH=33h, AL=00h` get Ctrl-C checking state | Saves returned `DL` at load offset `0525h`. |
| `071Fh` | `AH=33h, AL=01h` set Ctrl-C checking state | Sets `DL=00h`, disabling DOS Ctrl-C checking while the utility runs. |
| `0764h` | `AH=2Fh` get current DTA | Saves returned `ES:BX` at `062Ah:062Ch`. |
| `077Ah` | `AH=19h` get current drive | If no drive was supplied, converts returned zero-based drive number to an ASCII drive letter and stores it in the search buffer. |
| `0791h` | `AH=1Ah` set DTA | Sets `DS:DX=CS:0535h`; the program-owned DTA is in its data/workspace area. |
| `079Dh` | `AH=4Eh` find first | Searches `DS:DX=CS:06BEh` with `CX=0008h` attribute mask. |
| `07B1h` | `AH=4Fh` find next | Repeats directory enumeration using the DTA at `0535h`. |
| `07DBh` | `AH=47h` get current directory | Uses `DL` as the drive number and writes the path into `CS:0634h`. |
| `091Ah` | `AH=43h, AL=00h` get file attributes | Queries the constructed path at `CS:0675h`; `CL` is tested for the directory attribute bit. |
| `095Ah` | `AH=4Eh` find first | Searches the normalized specification at `CS:0675h` with `CX=00F1h`, accepting the desired file/directory attribute mask. |
| `097Ah` | `AH=4Fh` find next | Continues the main directory scan. |
| `09E8h` | `AH=33h, AL=01h` restore Ctrl-C checking | Restores the saved `DL` from `0525h`. |
| `09ECh` | `AH=00h` terminate | `AX=0000h`; terminates through DOS after restoring state. |
| `0AF7h` | `AH=36h` get free disk space | `DL` is the selected drive number (`drive letter - 40h`); returned cluster/sector counts are multiplied to produce byte totals. |
| `0BB4h` | `AH=07h` direct console input, no echo | Loops until Enter (`0Dh`) or Ctrl-C (`03h`); used for pagination. |

## BIOS video `INT 10h` calls

| Sites | Function | Register setup / observed purpose |
|---:|---|---|
| `0709h` | `AH=08h` read character/attribute | `BH=07h`; saves the returned attribute at `062Eh`, apparently preserving the current display attribute. |
| `09D4h`, `09DEh` | `AH=06h` scroll-up / clear window | `AL=00h`, `BH=07h`, `CX=1500h`, `DX=184Fh`; clears the display region. |
| `09AFh`, `09BFh` | `AH=02h` set cursor position | `BH=07h`, row `1Ah`, columns `00h` or `00h` on the two exit paths. |
| `0AECh` | `AH=02h` set cursor position | `BH=07h`, row `15h`, column `00h`, before volume-total output. |
| `0B48h` | `AH=06h` scroll-up / clear window | `AL=00h`, `BH=0Eh`, `CX=0000h`, `DX=184Fh`; clears the main output area with a different attribute. |
| `0B51h` | `AH=02h` set cursor position | `BH=07h`, `DX=0000h`; positions output for summary data. |
| `0BCEh` | `AH=06h` scroll-up / clear window | `AL=00h`, `BH=71h`, `CX=0500h`, `DX=144Fh`; initializes the directory display window. |
| `0BD8h`, `0BFAh` | `AH=02h` set cursor position | Sets the initial heading position and then advances through the two-column rows. |
| `0DB8h` | `AH=0Eh` teletype output | `AL` is masked with `7Fh`; page `BH=07h`. This is the single-character output helper. |
| `0DC8h` | `AH=0Eh` teletype output | Outputs the low seven bits of each `CS:SI` byte until the high bit marks the final byte. |

## DTA reconstruction

The program sets its DTA to load offset `0535h` and subsequently accesses the
standard DOS find-result fields at these offsets:

| DTA-relative offset | Load offset | Observed use |
|---:|---:|---|
| `15h` | `054Ah` | Attribute byte; bit `10h` identifies directories. |
| `16h` | `054Bh` | Time word copied to the internal record. |
| `18h` | `054Dh` | Date word copied to the internal record. |
| `1Ah` | `054Fh` | Four-byte file size copied and accumulated into the total byte counter. |
| `1Eh` | `0553h` | 13-byte DOS 8.3 name field, normalized and copied. |

This alignment is strong evidence that the program is using the ordinary DOS
find-first/find-next DTA layout, including the 21-byte DOS-private prefix.

## Preliminary internal-record reconstruction

The temporary record begins at load offset `05BFh`. The code copies it in
`0Bh` words (`16h` bytes) to the sorted-record area, so the record stride is
22 bytes.

| Record offset | Size | Working interpretation | Evidence |
|---:|---:|---|---|
| `00h` | 1 | Directory/file classification byte | Derived from DTA attribute byte; directory bit causes the value to become zero and increments the directory count. |
| `01h-0Dh` | 13 | Normalized 8.3 name field, including DOS terminator/padding | Thirteen bytes copied from DTA name at `0553h`; alphabetic characters are uppercased and selected special characters are mapped. |
| `0Eh-11h` | 4 | File size, low word then high word | Two `LODSW/STOSW` pairs from DTA `054Fh`. |
| `12h-13h` | 2 | Date | `MOVSW` from DTA `054Dh`. |
| `14h-15h` | 2 | Time | `MOVSW` from DTA `054Bh`. |

The record layout is therefore well supported. The exact character-mapping
purpose of the transformed name bytes, and whether the first classification
byte is also deliberately part of the sort key, remain open questions.
