#!/usr/bin/env python3
"""Stream annotated Swiss-Prot flat-file records into Plant-mSubP BLAST FASTA."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import re


def records(handle):
    record = []
    for line in handle:
        record.append(line.rstrip("\n"))
        if line.startswith("//"):
            yield record
            record = []
    if record:
        raise ValueError("Incomplete final Swiss-Prot record; check the download")


def parse_record(lines):
    accession, entry, declared_length = None, None, None
    reviewed, in_sequence, in_location = False, False, False
    locations, description, sequence = [], [], []
    for line in lines:
        if line.startswith("ID   "):
            entry = line[5:].split()[0]
            reviewed = " Reviewed;" in line
            match = re.search(r"(\d+) AA\.", line)
            declared_length = int(match[1]) if match else None
        elif line.startswith("AC   ") and accession is None:
            accession = line[5:].split(";")[0].strip()
        elif line.startswith("DE   "):
            description.append(line[5:].strip())
        elif line.startswith("CC   "):
            comment = line[5:].strip()
            if comment.startswith("-!- "):
                in_location = comment.startswith("-!- SUBCELLULAR LOCATION:")
                if in_location:
                    locations.append(comment.split(":", 1)[1].strip())
            elif comment.startswith("---"):
                in_location = False
            elif in_location:
                locations.append(comment)
        elif line.startswith("SQ   "):
            in_sequence = True
        elif line.startswith("//"):
            in_sequence = False
        elif in_sequence and line.startswith("     "):
            sequence.append("".join(line.split()))
    sequence = "".join(sequence)
    if not accession or not entry or declared_length != len(sequence):
        raise ValueError(f"Invalid or truncated record: {accession or entry or 'unknown'}")
    if set(sequence) - set("ACDEFGHIKLMNPQRSTVWYBXZJUO"):
        raise ValueError(f"Unexpected sequence characters: {accession}")
    return accession, entry, reviewed, " ".join(locations), " ".join(description), sequence


def safe_title(value):
    return " ".join(value.replace("::", ":").split())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="uniprot_sprot.dat.gz or uncompressed .dat")
    parser.add_argument("--output", type=Path, default=Path("blast_db"))
    parser.add_argument("--release", required=True, help="Source release, e.g. 2026_03")
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    fasta = args.output / "subcellular_localization_db.fasta"
    if fasta.exists() or list(args.output.glob("subcellular_localization_db.p*")):
        raise FileExistsError("Database output already exists; choose a new output directory")
    digest = hashlib.sha256()
    with args.input.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    counts = {"total_records": 0, "included_records": 0, "without_location": 0, "unreviewed_records": 0}
    seen = set()
    temporary = fasta.with_suffix(".fasta.partial")
    opener = gzip.open if args.input.suffix == ".gz" else open
    try:
        with opener(args.input, "rt", encoding="utf-8") as source, temporary.open("w") as target:
            for lines in records(source):
                accession, entry, reviewed, location, description, sequence = parse_record(lines)
                counts["total_records"] += 1
                if not reviewed:
                    counts["unreviewed_records"] += 1
                    continue
                if not location:
                    counts["without_location"] += 1
                    continue
                if accession in seen:
                    raise ValueError(f"Duplicate primary accession: {accession}")
                seen.add(accession)
                target.write(f">{accession} {accession}::{safe_title(location)}::{entry} {safe_title(description)}\n")
                for offset in range(0, len(sequence), 80):
                    target.write(sequence[offset:offset + 80] + "\n")
                counts["included_records"] += 1
        if not counts["included_records"]:
            raise ValueError("No reviewed records with subcellular location annotations found")
        temporary.rename(fasta)
    except BaseException:
        temporary.unlink(missing_ok=True)
        raise
    metadata = {
        "source": "UniProtKB/Swiss-Prot", "release": args.release,
        "input_file": args.input.name, "input_sha256": digest.hexdigest(),
        "selection": "Reviewed entries with a SUBCELLULAR LOCATION comment; all organisms",
        "annotation_policy": "Full source location comment retained, including evidence and qualifiers; no inferred 14-class mapping",
        **counts,
    }
    (args.output / "manifest.json").write_text(json.dumps(metadata, indent=2) + "\n")
    summary = f"UniProtKB/Swiss-Prot {args.release}: {counts['included_records']:,} reviewed proteins with subcellular location annotations."
    (args.output / "database-info.txt").write_text(summary + "\n")
    print(summary)
    print(f"Records without localization: {counts['without_location']:,}")


if __name__ == "__main__":
    main()
