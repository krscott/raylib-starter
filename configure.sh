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
    cmake -B build/desktop
    ;;

win)
    # https://jcbhmr.com/2024/07/19/zig-cc-cmake/
    ASM="zig cc" \
        CC="zig cc" \
        CXX="zig c++" \
        cmake \
        -DCMAKE_SYSTEM_NAME="Windows" \
        -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
        -DCMAKE_ASM_COMPILER_TARGET="x86_64-windows-gnu" \
        -DCMAKE_C_COMPILER_TARGET="x86_64-windows-gnu" \
        -DCMAKE_CXX_COMPILER_TARGET="x86_64-windows-gnu" \
        -DCMAKE_AR="$PWD/zig-ar" \
        -DCMAKE_RANLIB="$PWD/zig-ranlib" \
        -B build/windows
    ;;

web)
    # ./emsdk/emsdk activate latest
    # . ./emsdk/emsdk_env.sh
    (
        mkdir -p build/web
        cd build/web
        emcmake cmake ../.. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXECUTABLE_SUFFIX=".html"
    )
    ;;

*)
    usage
    exit 1
    ;;
esac
