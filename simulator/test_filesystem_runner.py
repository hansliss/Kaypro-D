#!/usr/bin/env python3
"""Small tests for the quiet Unix-filesystem D.COM wrapper."""

from __future__ import annotations

import os
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from run_filesystem import import_filesystem, run


class FilesystemRunnerTests(unittest.TestCase):
    def test_import_filters_and_maps_entries(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "README.TXT").write_bytes(b"hello")
            (root / "DOCS").mkdir()
            (root / "DOCS" / "INNER.BIN").write_bytes(b"123")
            (root / "too-long-name.txt").write_bytes(b"skip")
            if hasattr(os, "symlink"):
                (root / "LINK.TXT").symlink_to(root / "README.TXT")

            entries = import_filesystem(root)
            self.assertEqual(
                [(entry.path, entry.name, entry.directory, entry.size)
                 for entry in entries],
                [
                    (".", "DOCS", True, 0),
                    (".", "README.TXT", False, 5),
                    ("DOCS", "INNER.BIN", False, 3),
                ],
            )

    def test_wrapper_runs_without_trace_output(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "HELLO.TXT").write_bytes(b"hello")
            output = run(root, "")
            self.assertIn("hello   .txt", output.lower())
            self.assertIn("\x1b[6;1H", output)
            self.assertNotIn("\x1b[2J", output)
            self.assertNotIn('"kind"', output)


if __name__ == "__main__":
    unittest.main()
