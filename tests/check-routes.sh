#!/usr/bin/env bash
set -euo pipefail
BASE_URL="${1:-http://localhost:3838}"
BASE_URL="${BASE_URL%/}"

check_status() {
    local path="$1" expected="$2" actual
    actual=$(curl --silent --show-error --max-time 120 -o /dev/null -w '%{http_code}' "$BASE_URL$path")
    [[ "$actual" == "$expected" ]] || {
        echo "FAIL $path: expected $expected, got $actual" >&2
        exit 1
    }
    echo "PASS $path: $actual"
}

check_status /Plant-mSubP/ 200
check_status /Plant-mSubP 301
location=$(curl --silent --show-error -D - -o /dev/null "$BASE_URL/Plant-mSubP?check=1" | tr -d '\r' | sed -n 's/^[Ll]ocation: //p')
[[ "$location" == "/Plant-mSubP/?check=1" ]] || {
    echo "FAIL canonical redirect: $location" >&2
    exit 1
}
check_status / 404
check_status /plant-msubp/ 404
check_status /Plant-mSubP-other/ 404
check_status /Plant-mSubP/server.R 404
check_status /Plant-mSubP/training/sequences/Plastid_train_filter.fasta 200
check_status /Plant-mSubP/testing/sequences/Plastid_Inde.fasta 200
