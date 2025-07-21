# raylib-starter

A starter project for C Raylib with optional support for Nix.

[Web Demo](https://krscott.github.io/raylib-starter/raylib-starter.html)

![build](https://github.com/krscott/raylib-starter/actions/workflows/build.yml/badge.svg)

## Usage

To compile the example, use one of the following dependending on your build target...

### Desktop

Use the following to build for desktop:

``` bash
cmake -B build
cmake --build build
```

### Web

Compiling for the web requires the [Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html):

``` bash
mkdir build
cd build
emcmake cmake .. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXECUTABLE_SUFFIX=".html"
emmake make
```
