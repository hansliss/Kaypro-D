# Simulation fixture results

These observations come from the first deterministic harness run, using the
mock DOS/BIOS environment in `simulator/dos_harness.py`. They are execution
observations of the current model, not yet proof that the same fixture would
produce identical behavior under the original DOS environment.

## Suite result

Twenty-six scenarios completed and terminated through DOS `AH=00h`. The
`deep-nested-path` case uses fourteen nested path components and exercises the
full current-search-path buffer through load offset `06B7h`; the
`long-current-directory` case exercises the DOS current-directory destination
through `0670h`. Both still produce valid sorted records:

| Scenario | Entries | Instructions | Result |
|---|---:|---:|---|
| `mixed-directory` | 3 | 10,998 | directory and files rendered |
| `punctuation-and-case` | 4 | 12,674 | normalized/mapped names rendered |
| `size-extremes` | 3 | 11,379 | all sizes accepted |
| `empty-directory` | 0 | 461 | clean no-result termination |
| `nested-command-tail` | 1 | 8,987 | path-aware nested search accepted `INNER.TXT` |
| `pagination` | 20 | 37,174 | multi-page traversal completed |
| `pagination-before-boundary` | 14 | 26,782 | pre-boundary case completed |
| `pagination-at-boundary` | 15 | 27,997 | boundary case completed |
| `pagination-after-boundary` | 16 | 30,364 | post-boundary case completed |
| `no-match` | 0 accepted | 500 | clean no-match termination |
| `invalid-path` | 0 accepted | 515 | invalid-path termination path completed |
| `mapping-table` | 16 | 29,233 | special-character mapping exercised |
| `volume-label` | 2 | 10,137 | volume-label filtering exercised |
| `explicit-drive` | 1 | 9,097 | valid explicit-drive path exercised |
| `trailing-directory-slash` | 0 accepted | 8,962 | trailing-separator path completed |
| `deep-nested-path` | 1 | 9,242 | full current-search-path buffer exercised |
| `long-current-directory` | 1 | 9,412 | long DOS current-directory result exercised through `0670h` |
| `single-dot-command` | 1 | 9,012 | single-dot command-tail branch exercised |
| `parent-directory-command` | 1 | 9,195 | parent-directory command-tail branch exercised |
| `invalid-parent-directory` | 0 accepted | 545 | root-level parent-directory error path completed |
| `directory-target` | 1 | 8,608 | directory-target fixture completed |
| `control-c-pagination` | 20 | 37,835 | Ctrl-C abort path exercised |
| `initial-error` | 0 accepted | 285 | nonzero initial AX/error path completed |
| `capacity-before` | 9 | 19,622 | one slot below synthetic capacity |
| `capacity-at` | 10 | 4,428 | exact synthetic capacity |
| `capacity-after` | 11 supplied / 10 stored | 4,437 | excess entry rejected at capacity |

Complete event logs are generated under `simulator/logs/` when the suite is
run. They are intentionally ignored by version control because they are
derived artifacts; the suite can regenerate them.

## Observations supported by the traces

### Record pipeline

The harness observes the expected pipeline:

```text
mock DTA result
  -> 09F0h temporary 22-byte record
  -> 0A64h insertion/comparison
  -> sorted record storage at 0DDBh+
  -> two-column rendering
```

The temporary-record and sorted-storage snapshots agree with the previously
reconstructed 22-byte geometry.

### Ordering

The mixed fixture produced this final order:

```text
DOCS, ALPHA, ZETA
```

The size-extremes fixture produced:

```text
BIG, EMPTY, ONE
```

This is consistent with the classification byte being ordered before the
normalized name, followed by name ordering. It is inconsistent with sorting
by file size. This strengthens—but does not yet prove—the current sort-key
model.

### Name normalization

Alphabetic names are uppercased in the internal record and displayed in the
utility's lower-case presentation. The period between base name and extension
is represented internally by a small mapping byte rather than a literal ASCII
period. Punctuation such as `+` and `-` is also mapped through the table at
load offset `06DAh`; the resulting bytes can be control-valued and therefore
appear unusual in a raw trace.

This is a strong lead for reconstructing the name-comparison alphabet, but the
mapping table should be decoded from the code and tested against more
characters before being described as a complete collation order.

### Pagination

The 20-entry fixture exercises the page loop and direct console input. The
program makes repeated `AH=07h` reads and completes after synthetic carriage
returns. The trace therefore supports the existence of a page boundary and a
pause/continue mechanism, while the exact screen-row threshold still needs to
be isolated from the rendering loop.

### Nested command-tail path

After making the mock filesystem path-aware, the `DOCS\\*.TXT` fixture matches
an `INNER.TXT` entry whose parent path is `DOCS`. The root search is empty, the
normalized nested search matches one record, and the record reaches rendering.
This confirms that the harness can now distinguish root and nested searches;
it does not by itself prove that every DOS path edge case is modelled.

### Instruction coverage

The suite now records instruction-start coverage against the executable region
(`06F2h` through the end of the code at `0DDAh`). Representative coverage:

| Scenario | Instruction-start coverage |
|---|---:|
| `mixed-directory` | 74.68% |
| `punctuation-and-case` | 75.19% |
| `size-extremes` | 74.81% |
| `empty-directory` | 24.81% |
| `nested-command-tail` | 67.22% |
| `pagination` | 73.92% |
| `pagination-before-boundary` | 70.90% |
| `pagination-at-boundary` | 70.90% |
| `pagination-after-boundary` | 71.00% |
| `no-match` | 25.10% |
| `invalid-path` | 25.10% |
| `mapping-table` | 71.30% |

This is a useful first map of unexercised paths. Across the suite, 73
conditional branch sites are statically identified; the richest cases exercise
49 sites, with both edges observed at 22 sites in the mapping-table case. The
remaining branch gaps are directly visible in each scenario JSON log.

The remaining unexecuted instruction starts cluster in the low-level error,
console-output, alternate formatting, and termination paths. Several are
alignment/padding or deliberately bypassed helper paths, so they should be
resolved by static control-flow review rather than by inventing increasingly
artificial fixtures.

The current classification is:

| Uncovered range(s) | Working classification |
|---|---|
| `07B7h-07B8h`, `09EEh-09EFh` | two-byte alignment/padding after short jumps |
| `07FEh-0801h`, `081Ch-081Fh`, `0867h-086Ah`, `0890h-0891h` | alternate command-tail deletion/scan loop edges not reached by the valid fixture set |
| `0835h-0837h` | root-level parent-directory error entry; the modeled parser reports the same error through an earlier path |
| `091Eh-0926h` | directory-target separator append branch; the current mock's attribute/path normalization bypasses this exact edge |
| `09A6h-09B4h` | statically present abort-screen helper with no executed call site in the reconstructed control flow |
| `0A23h`, `0C08h`, `0CABh-0CB6h` | alternate name/directory-formatting exits; not reached by the current record shapes |
| `0DB8h-0DC7h` | standalone BIOS character-output helper; all observed output uses the marked-string helper instead |

These classifications are useful reconstruction results even without forcing
execution. Reaching the remaining ranges would require synthetic register or
memory state, or a more speculative DOS model, and would not materially
increase confidence in the normal program paths.

Considering the union of the 26 executions, 744 of 790 executable instruction
starts were reached (94.18%). This is the suite-level figure; the per-scenario
figures above show which paths depend on particular fixtures.

## Memory coverage

The harness now traces every data read and write and classifies each accessed
byte. Across the 26 scenarios, 1,628 byte addresses are accessed. The complete
union and region interpretation are recorded in
`analysis/runtime-memory-coverage.md`; no observed access remains classified
as unmapped. The high addresses `FFE6h-FFFDh` are the program's COM stack, not
an unknown external area.

## Next experiments

The next suite refinement should:

1. compare insertion positions directly for pairs of names;
2. decode and assert the `06DAh` character mapping table;
3. inspect the remaining unexecuted conditional edges and design minimal
   fixtures for them;
4. validate invalid-drive behavior against a more faithful DOS error model;
5. run a deliberately optimized full-size stress probe if the execution time
   is justified; the controlled capacity boundary is now verified.
