#!/usr/bin/env bash
set -euo pipefail
shopt -s failglob
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

platform="${1:-desktop}"

usage() {
    echo "$0 [PLATFORM]"
}

case "$platform" in
desktop)
    (
        cd build/desktop/src
        ./raylib-starter
    )
    ;;
win)
    echo "Cannot run windows build from linux"
    exit 1
    ;;
web)
    (
        cd build/web/src
        python -m http.server
    )
    ;;
*)
    usage
    exit 1
    ;;
esac
