#!/usr/bin/env bash
set -euo pipefail
shopt -s failglob
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

nix build --print-build-logs '.?submodules=1#'
nix build --print-build-logs '.?submodules=1#windows'
nix build --print-build-logs '.?submodules=1#web'
