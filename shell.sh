#!/usr/bin/env sh
set -eu

nix-shell -p \
    zig \
    cmake

# libGL \
# xorg.libX11 \
# xorg.libX11.dev \
# xorg.libXcursor \
# xorg.libXi \
# xorg.libXinerama \
# xorg.libXrandr
