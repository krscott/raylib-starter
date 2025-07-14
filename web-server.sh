#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

cd build/web/src
python -m http.server
