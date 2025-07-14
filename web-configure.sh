#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

./emsdk/emsdk activate latest
. ./emsdk/emsdk_env.sh

mkdir -p build
cd build
emcmake cmake .. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXECUTABLE_SUFFIX=".html"
