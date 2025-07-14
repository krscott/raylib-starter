#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

nix-shell -p \
    zig \
    cmake \
    python3 \
    binaryen

# libGL \
# xorg.libX11 \
# xorg.libX11.dev \
# xorg.libXcursor \
# xorg.libXi \
# xorg.libXinerama \
# xorg.libXrandr
