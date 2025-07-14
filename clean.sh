#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

rm -rf build/
