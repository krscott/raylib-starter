#!/usr/bin/env bash
set -euo pipefail
shopt -s failglob
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

platform="${1:-desktop}"

usage() {
    echo "$0 [PLATFORM]"
}

build() {
    ./build.sh "$platform"
}

case "$platform" in
    desktop)
        (
            build
            cd build/desktop/src
            ./raylib-starter
        )
        ;;
    windows | win)
        echo "Cannot run windows build from linux"
        exit 1
        ;;
    web)
        (
            build
            cd build/web/src
            python -m http.server
        )
        ;;
    *)
        usage
        exit 1
        ;;
esac
