#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

./emsdk/emsdk activate latest
. ./emsdk/emsdk_env.sh

cd build
emmake make

# NOTE: To fix missing libatomic.so.1, install libatomic1
# Or, on nix, copy from binaryen. e.g.
#   cp /nix/store/dj557yw8nrfl5v4yfl3v7y4cpfmgcahp-binaryen-123/bin/* emsdk/upstream/bin/
# see: https://github.com/emscripten-core/emsdk/issues/928
