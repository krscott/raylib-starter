#!/usr/bin/env bash
set -euo pipefail
shopt -s failglob
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

platform="${1:-desktop}"

usage() {
    echo "$0 [PLATFORM]"
}

configure_if_needed() {
    if ! [[ -d build/$1 ]]; then
        ./configure.sh "$@"
    fi
}

case "$platform" in
    desktop)
        (
            configure_if_needed desktop

            set -x
            cmake --build build/desktop
        )
        ;;

    windows | win)
        (
            configure_if_needed windows -z

            set -x
            cmake --build build/windows
        )
        ;;

    web)
        # NOTE: To fix missing libatomic.so.1, install libatomic1
        # Or, on nix, copy from binaryen. e.g.
        #   cp /nix/store/dj557yw8nrfl5v4yfl3v7y4cpfmgcahp-binaryen-123/bin/* emsdk/upstream/bin/
        # see: https://github.com/emscripten-core/emsdk/issues/928

        # ./emsdk/emsdk activate latest
        # . ./emsdk/emsdk_env.sh
        (
            configure_if_needed web

            cd build/web
            set -x
            emmake make
            mv src/*.html src/index.html
        )
        ;;

    *)
        usage
        exit 1
        ;;
esac
