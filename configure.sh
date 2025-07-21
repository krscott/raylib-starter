#!/usr/bin/env bash
set -euo pipefail
shopt -s failglob
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

usage() {
    echo "$0 [-h] [-z] [PLATFORM]" >&2
}

show_help() {
    usage
    cat <<EOS >&2
Options:
  -h  --help    Show help and exit
  -z  --zig     Use zig cc
EOS
}

platform=
use_zig=

while [[ $# -gt 0 ]]; do
    case "$1" in
    --help | -h)
        show_help
        exit
        ;;
    --zig | -z)
        use_zig=1
        ;;
    -*)
        echo "Unknown option: $1" >&2
        usage
        exit 1
        ;;
    *)
        if [[ -z $platform ]]; then
            platform="$1"
        else
            echo "Too many positional arguments" >&2
            usage
        fi
        ;;
    esac

    shift 1 # Move to the next argument
done

case "${platform:-desktop}" in
desktop)
    cmake -B build/desktop
    ;;

windows | win)
    if [[ $use_zig == 1 ]]; then
        # https://jcbhmr.com/2024/07/19/zig-cc-cmake/
        ASM="zig cc" \
            CC="zig cc" \
            CXX="zig c++" \
            cmake -B build/windows \
            -DCMAKE_SYSTEM_NAME="Windows" \
            -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
            -DCMAKE_ASM_COMPILER_TARGET="x86_64-windows-gnu" \
            -DCMAKE_C_COMPILER_TARGET="x86_64-windows-gnu" \
            -DCMAKE_CXX_COMPILER_TARGET="x86_64-windows-gnu" \
            -DCMAKE_AR="$PWD/zig-ar" \
            -DCMAKE_RANLIB="$PWD/zig-ranlib"
    else
        cmake -B build/windows \
            -DCMAKE_SYSTEM_NAME="Windows" \
            -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
            -DCMAKE_ASM_COMPILER_TARGET="x86_64-windows-gnu" \
            -DCMAKE_C_COMPILER_TARGET="x86_64-windows-gnu" \
            -DCMAKE_CXX_COMPILER_TARGET="x86_64-windows-gnu"
    fi
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
