# Kaypro D.COM reconstruction

This project documents and reconstructs a 3,552-byte 8086/8088 MS-DOS
`D.COM` utility. The program is an enhanced directory lister: it processes
the DOS command tail, searches through the DOS DTA, sorts records, calculates
volume totals, and renders a two-column directory display with pagination and
Ctrl-C handling.

The image is believed to be Kaypro software extracted from Install Disk 1 of
the Kaypro PC MS-DOS disk set. The disk images are hosted by the
[Kaypro Journal Kaypro PC page](https://kayprojournal.com/index.php/Kaypro_PC#Disks),
which links the six Install Disk images. `reference/D.COM` is the immutable
binary under reconstruction.

## Reconstructed source

[`src/D.asm`](src/D.asm) is a commented NASM source reconstruction. It is
organized as:

- non-emitting DOS, BIOS, PSP, and allocation constants at the top;
- the pre-code strings, display templates, variables, DTA, tables, and
  reserved workspace;
- the executable region beginning at load offset `06F2h`;
- the sorted-record storage area at load offset `0DDBh`.

The source is deliberately conservative. Confirmed instructions are written
as mnemonics; original register-register encodings that NASM would emit
differently remain as `db` pairs with comments explaining the mnemonic. Data
boundaries and labels are promoted only where supported by code references,
static byte evidence, or execution traces.

Build and verify it with:

```sh
nasm -f bin src/D.asm -o /tmp/D.COM
cmp reference/D.COM /tmp/D.COM
```

The current reconstruction assembles byte-for-byte identically to the
reference image. Intermediate source refinements are preserved as
`src/D-v*.asm`, including the initial byte-oriented source, routine
conversions, string identification, runtime labels, data-buffer formatting,
and reference-label passes.

## Analysis history

The reconstruction began by comparing the `ndisasm` and `objdump` listings,
then separating the initial data/workspace area from the executable entry at
`06F2h`. The process proceeded through these milestones:

1. preserve a byte-exact baseline;
2. identify strings, marked-string terminators, display templates, and tables;
3. name confirmed subroutines and DOS/BIOS calls;
4. convert high-confidence executable regions to instructions while preserving
   alternate original encodings as raw bytes;
5. identify runtime variables, the 43-byte DOS DTA, the 22-byte internal
   record, sorted-record storage, path buffers, and character tables;
6. build a Unicorn-based DOS/BIOS simulation harness;
7. add instruction, branch, CPU memory, and mocked-service memory coverage;
8. use targeted fixtures to validate nested paths, long paths, `.`/`..`
   command handling, directory targets, pagination, mapping characters,
   volume labels, capacity limits, and error behavior;
9. normalize confirmed data buffers with `times` expressions while retaining
   exact mixed-content bytes.

Detailed findings are in [`analysis/`](analysis/), especially:

- [`source-reconstruction.md`](analysis/source-reconstruction.md) — milestone
  history and current reconstruction state;
- [`memory-map.md`](analysis/memory-map.md) — static memory layout;
- [`functions.md`](analysis/functions.md) — routine boundaries and behavior;
- [`dos-calls.md`](analysis/dos-calls.md) — DOS/BIOS calls and DTA fields;
- [`variables.md`](analysis/variables.md) — runtime state and data objects;
- [`workspace-access-map.md`](analysis/workspace-access-map.md) — combined
  static and execution-oriented data-access interpretation;
- [`simulation-results.md`](analysis/simulation-results.md) — fixture results,
  coverage, and classification of remaining code gaps.

## Simulation harness

[`simulator/dos_harness.py`](simulator/dos_harness.py) executes the original
binary with Unicorn in 16-bit mode. It supplies a synthetic PSP, DOS DTA,
filesystem, console input, and the observed DOS/BIOS services. Unsupported
services fail loudly rather than being guessed.

Run the complete deterministic suite with:

```sh
.venv/bin/python simulator/test_suite.py
```

The suite currently contains 26 scenarios and reaches 744 of 790 identified
instruction starts (94.18%). The remaining starts are classified as alignment
bytes, alternate loop edges, unreferenced helpers, or rare formatting/error
exits. The simulator also records memory accesses made directly by mocked DOS
services, which is necessary for observing DTA population and DOS string
reads.

## Interesting quirks

- The program is a `.COM` image and assumes the usual PSP-relative segment
  setup, with code beginning at load offset `0100h`.
- The initial `05F2h` file area / `06F2h` load address boundary separates a
  large initialized data/workspace region from executable code.
- DOS marked strings use a high-bit terminator rather than a conventional
  NUL terminator. Several line endings are `0Dh, 8Ah`, with bit 7 set on the
  line-feed byte.
- The internal sorted record is 22 bytes and contains a classification byte,
  normalized name material, size, date, and time fields.
- The program uses valid but noncanonical 8086 register-register encodings;
  NASM does not always reproduce them, so those bytes are retained explicitly.
- The explicit-drive parser has a real precondition: an empty command tail
  with a nonzero PSP FCB drive underflows the tail-length byte and corrupts
  the search buffer. The valid fixture uses a nonempty `C:\\...` command.
- The simulator's DOS model is intentionally not a general DOS emulator. Its
  observations support reconstruction of this program, not proof of behavior
  on every DOS version or filesystem.

## Final status

The byte-level reconstruction is complete and reproducible. The remaining
uncertainties concern the semantics of untouched workspace and a small set of
rare or bypassed code paths, not missing bytes or unresolved executable
boundaries.
