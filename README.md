# plant-msubp

This repository provides a script to build and run Plant-mSubP on a Docker-enabled host.

The application is served only at `/Plant-mSubP/` (case sensitive). `/Plant-mSubP` redirects to the trailing-slash URL. The container returns 404 for `/`, lowercase variants, and unrelated paths.

This application predicts the subcellular localization of proteins using sequence-based features and machine learning. It supports both single-location and multi-location protein prediction, covering 11 cellular compartments and 3 biologically relevant multi-location classes.

Protein sequences are represented using a combination of composition-based and physicochemical descriptors, including amino acid composition, dipeptide composition, pseudo amino acid composition, and hybrid feature sets to improve prediction accuracy.

---

## Requirements

* Docker installed and running
* An AMD64 host or Docker's AMD64 emulation (the `rocker/shiny:4.3.2` base image is AMD64)
* Permission to run docker
* Port `3838` available

---

## Quick Start

Build and run the service:

```bash
./build-docker.sh
```

Open `http://localhost:3838/Plant-mSubP/` after the build completes. Rebuild the image to apply the routing change; restarting an older image is insufficient.

This will:

* build the Docker image
* start the service container
* restart it automatically unless stopped

The script can be called from any working directory. It builds the new image before replacing the running container, so a failed build leaves the current service running.

---

## Networking

The container runs on a Docker network named:

```
webapps-net
```

The network is created automatically if it does not exist.

---

## Image Tags

Each build creates:

* a timestamped image tag (for reference)
* a stable tag (`current`) used to run the container

The running container always uses the `current` tag.

---

## Service Details

* Container name: `plant-msubp`
* Port mapping:

  ```
  3838 -> 3838
  ```
* Restart policy: `unless-stopped`

## Reverse proxy

Include `deploy/nginx-location.conf` inside the existing nginx `server` block, then validate and reload nginx. The nginx container must share `webapps-net` with `plant-msubp`. If nginx runs on the host, replace `http://plant-msubp:3838` with `http://127.0.0.1:3838`.

Preserve `/Plant-mSubP/` when proxying: `proxy_pass` must have no trailing slash. The included configuration handles the canonical redirect, WebSocket connections, uploads, and long-running predictions.

## Portable file paths

App assets and model files use paths relative to `Plant-mSubP/`. Temporary query files use R's temporary directory. Historical R scripts should be run from `Plant-mSubP/`; they no longer refer to a user's home directory or an installed Shiny Server tree.

`scripts/bestModelCalc.R` reads results from `training/models` by default. Set `PLANT_MSUBP_RESULTS_DIR` to use a different results directory.

Analytics are optional: the app loads `google-analytics.js` only if the file exists. Access logging is disabled by default. To enable the legacy IP lookup and access log, set `PLANT_MSUBP_ACCESS_LOG` to a writable log file outside `www/`.

## Optional Protein BLAST module

The container includes BLAST+ executables. The formatted database is supplied separately; it is not included in this repository. The four sequence-based prediction modules work without it. If the database is unavailable, selecting Protein BLAST shows an availability message.

To use the existing database, set `PLANT_MSUBP_BLAST_DB_DIR` to its directory before running `./build-docker.sh`. The script mounts that directory read-only at `/opt/blast_db`; the database prefix must be `subcellular_localization_db`. The R app uses `PLANT_MSUBP_BLAST_DB` for the database prefix if a different deployment configures it.

## Verification

To build the reference from a downloaded Swiss-Prot annotated text file:

```bash
docker build --platform linux/amd64 -t plant-msubp:current .
bash scripts/build-swissprot-db.sh swissprot/uniprot_sprot.dat.gz 2026_03 blast_db
PLANT_MSUBP_BLAST_DB_DIR="$(pwd)/blast_db" ./build-docker.sh
```

The builder requires Python 3 and Docker. It streams the gzip file without extracting the full annotated text to disk. It includes reviewed entries with a subcellular-location comment, retains their full annotations and evidence qualifiers, and writes release/count metadata plus a source checksum. Generated data are excluded from Git and Docker image builds. This creates a current reference across all organisms; it does not recreate the historical 2008 database or retrain the four SVM models.

With the service running, check its routes and dataset downloads:

```bash
bash tests/check-routes.sh http://localhost:3838
```

With the app's R dependencies installed, check startup, all four prediction modules, pasted and uploaded FASTA, clearing results, and invalid input:

```bash
Rscript tests/smoke.R
```
---


