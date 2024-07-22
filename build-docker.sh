#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

CONTAINER=plant-msubp
NETWORK=webapps-net
PORT="${PLANT_MSUBP_PORT:-3838}"
DATE_TAG=$(date +%Y%m%d%H%M%S)

# Optional: a directory containing the existing formatted BLAST database.
if [[ -n "${PLANT_MSUBP_BLAST_DB_DIR:-}" && ! -d "$PLANT_MSUBP_BLAST_DB_DIR" ]]; then
    echo "PLANT_MSUBP_BLAST_DB_DIR must be an existing directory" >&2
    exit 1
fi

docker info >/dev/null
if ! docker network inspect "$NETWORK" >/dev/null 2>&1; then
    docker network create "$NETWORK"
fi

# Remember unnamed containers created by older versions of this script.
old_containers=$(docker ps -aq --filter "ancestor=$CONTAINER:current")

# Keep the running service available if the build fails.
docker build --platform linux/amd64 -t "$CONTAINER:$DATE_TAG" .
docker tag "$CONTAINER:$DATE_TAG" "$CONTAINER:current"

if docker container inspect "$CONTAINER" >/dev/null 2>&1; then
    docker stop "$CONTAINER"
    docker rm "$CONTAINER"
fi
for old_container in $old_containers; do
    if docker container inspect "$old_container" >/dev/null 2>&1; then
        docker stop "$old_container"
        docker rm "$old_container"
    fi
done

run_flags=(-d --platform linux/amd64 --name "$CONTAINER" --restart unless-stopped
    -p "$PORT:3838" --network "$NETWORK")
if [[ -n "${PLANT_MSUBP_BLAST_DB_DIR:-}" ]]; then
    run_flags+=(--mount "type=bind,src=$PLANT_MSUBP_BLAST_DB_DIR,dst=/opt/blast_db,readonly")
fi

docker run "${run_flags[@]}" "$CONTAINER:current"
echo "Plant-mSubP: http://localhost:$PORT/Plant-mSubP/"
