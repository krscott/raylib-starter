#!/usr/bin/env sh
set -eu
cd "$(dirname "$(readlink -f -- "$0")")"

./emsdk/emsdk activate latest
. ./emsdk/emsdk_env.sh

mkdir -p build/web
cd build/web
emcmake cmake ../.. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXECUTABLE_SUFFIX=".html"
