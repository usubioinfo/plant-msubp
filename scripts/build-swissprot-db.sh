#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 3 ]]; then
    echo "Usage: bash scripts/build-swissprot-db.sh INPUT_DAT_GZ [RELEASE] [OUTPUT_DIR]" >&2
    exit 1
fi

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source_file="$1"
release="${2:-2026_03}"
output_dir="${3:-blast_db}"
image="${PLANT_MSUBP_IMAGE:-plant-msubp:current}"

docker image inspect "$image" >/dev/null
python3 "$script_dir/prepare-swissprot.py" "$source_file" --release "$release" --output "$output_dir"
output_dir=$(cd "$output_dir" && pwd)

docker run --rm --platform linux/amd64 \
    --mount "type=bind,src=$output_dir,dst=/work" \
    --entrypoint makeblastdb "$image" \
    -in /work/subcellular_localization_db.fasta -dbtype prot -parse_seqids \
    -title "Swiss-Prot $release with subcellular location annotations" \
    -out /work/subcellular_localization_db

docker run --rm --platform linux/amd64 \
    --mount "type=bind,src=$output_dir,dst=/work,readonly" \
    --entrypoint blastdbcmd "$image" \
    -db /work/subcellular_localization_db -info
