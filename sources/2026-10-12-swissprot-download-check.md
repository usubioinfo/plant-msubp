# Swiss-Prot download and Plant-mSubP compatibility check

Verified October 12, 2026 (America/Chicago).

Selection: current UniProtKB/Swiss-Prot reviewed protein database, not TrEMBL.

Official release statistics report release 2026_03, September 2, 2026, with 575,748 canonical sequence entries and 209,017,843 amino acids.

Sources:

- https://web.expasy.org/docs/relnotes/relstat.html
- https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/
- https://www.uniprot.org/help/fasta-headers
- https://www.uniprot.org/help/subcellular_location

HTTP HEAD checks of the official files returned:

- `uniprot_sprot.fasta.gz`: 93,801,562 bytes (93.80 MB, 89.46 MiB), last modified September 3, 2026.
- `uniprot_sprot.dat.gz`: 700,301,138 bytes (700.30 MB, 667.86 MiB), same modification date.

A four-byte HTTP range request for the FASTA gzip footer returned an uncompressed size of 288,201,213 bytes (288.20 MB, 274.85 MiB). No full database was downloaded during this check. Annotated text uncompressed size and BLAST index size were not measured.

Reproduce compressed size checks:

```bash
curl -I https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
curl -I https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.dat.gz
```

Plant-mSubP's current BLAST result parser splits subject titles using `::`; it expects an identifier, localization label, and description. Plain UniProt FASTA headers do not supply this custom localization label. An annotated database build must preserve the source release, select records with usable subcellular location annotations, construct compatible titles, and then format a protein BLAST database. A current database is a new reference and does not reproduce the legacy 2008 database or guarantee identical results.
