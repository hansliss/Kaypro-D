# 8086 encoding assembler probes

The reconstructed source contains several instructions whose original bytes
are semantically equivalent to NASM's output but use the opposite direction
encoding. Targeted probes were run without modifying `src/D.asm`.

## Available assemblers tested

- NASM 2.16.01
- GNU assembler 2.42 (`as`, both AT&T and Intel syntax)
- LLVM MC 16 and 18 (`.code16`, i386 target)
- radare2 `rasm2` 5.5.0 (`x86.nasm`/`x86.as` modes)

All tested assemblers emit the same canonical byte sequence for the probe:

| Source operation | Original encoding | Tested default encoding |
|---|---:|---:|
| `mov bx,ax` | `8B D8` | `89 C3` |
| `mov si,dx` | `8B F2` | `89 D6` |
| `add di,cx` | `03 F9` | `01 CF` |
| `xor dx,dx` | `33 D2` | `31 D2` |
| `mov ax,si` | `8B C6` | `89 F0` |
| `mov si,ax` | `8B F0` | `89 C6` |
| `mov ax,bx` | `8B C3` | `89 D8` |
| `or ax,si` | `0B C6` | `09 F0` |

The original consistently chooses the `8B`/`03`/`33`/`0B` forms in cases where
the destination is a register. The tested assemblers consistently choose the
corresponding `89`/`01`/`31`/`09` forms. These are identical in effect and
length, so they do not affect control-flow or data boundaries.

## Interpretation

This encoding policy is evidence about the original assembler family. It is
consistent with an older MASM/TASM-style encoder that preferred the opcode
whose ModR/M direction directly expresses a register destination. That is a
plausible explanation for the original bytes, but it is not proof of the exact
assembler without a historical toolchain probe.

The project owner reports that ChatGPT identified Microsoft MASM, Borland
Turbo Assembler, and Watcom WASM as assemblers known to emit `8B D8` for
`mov bx,ax`. That independently supplied information fits the probe results
and strengthens the historical-toolchain hypothesis, but has not been tested
against those assemblers in this Linux environment.

The current source therefore keeps the original forms as explicit `db` pairs
inside otherwise mnemonic routines. A future MASM/TASM-compatible assembler
could be tested if one becomes available, but rewriting the source solely to
chase these equivalent encodings is not currently justified.
