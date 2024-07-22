import gzip
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / "scripts" / "prepare-swissprot.py"
spec = importlib.util.spec_from_file_location("prepare_swissprot", SCRIPT)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


def record(accession="TEST0001", location=True, reviewed=True):
    status = "Reviewed" if reviewed else "Unreviewed"
    comment = (
        "CC   -!- SUBCELLULAR LOCATION: Cytoplasm {ECO:0000269|PubMed:1}.\n"
        "CC       Nucleus. Note=Condition-dependent localization.\n"
        "CC   -!- FUNCTION: This unrelated comment must not enter the location.\n"
    ) if location else "CC   -!- FUNCTION: An unrelated comment.\n"
    return (
        f"ID   TEST_PLANT {status}; 60 AA.\nAC   {accession};\n"
        "DE   RecName: Full=Test protein;\n" + comment +
        "SQ   SEQUENCE 60 AA;\n     " + "ACDEFGHIKLMNPQRSTVWY" * 3 + "\n//\n"
    )


class PrepareTests(unittest.TestCase):
    def test_multiline_annotation_and_evidence_are_retained(self):
        result = module.parse_record(record().splitlines())
        self.assertIn("ECO:0000269", result[3])
        self.assertIn("Nucleus", result[3])
        self.assertIn("Note=", result[3])
        self.assertNotIn("unrelated", result[3])

    def test_gzip_filter_and_provenance(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "reference.dat.gz"
            with gzip.open(source, "wt") as target:
                target.write(record() + record("TEST0002", location=False) + record("TEST0003", reviewed=False))
            output = root / "db"
            subprocess.run([sys.executable, str(SCRIPT), str(source), "--output", str(output), "--release", "test"], check=True, capture_output=True)
            metadata = json.loads((output / "manifest.json").read_text())
            self.assertEqual(metadata["included_records"], 1)
            self.assertEqual(metadata["without_location"], 1)
            self.assertEqual(metadata["unreviewed_records"], 1)
            self.assertEqual(metadata["input_file"], source.name)
            self.assertNotIn(str(root), json.dumps(metadata))
            fasta = (output / "subcellular_localization_db.fasta").read_text()
            self.assertIn("TEST0001::Cytoplasm", fasta)
            self.assertNotIn("TEST0002", fasta)

    def test_truncated_download_does_not_publish_partial_fasta(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "truncated.dat"
            source.write_text(record() + record("TEST0002").replace("//\n", ""))
            output = root / "db"
            result = subprocess.run([sys.executable, str(SCRIPT), str(source), "--output", str(output), "--release", "test"], capture_output=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertFalse((output / "subcellular_localization_db.fasta").exists())
            self.assertFalse((output / "subcellular_localization_db.fasta.partial").exists())


if __name__ == "__main__":
    unittest.main()
