{
  raylib-src,
  callPackage,
  pkgsCross,
}:
callPackage ./base.nix {
  inherit (pkgsCross.mingwW64) stdenv;

  suffix = "windows";

  inherit raylib-src;

  nativeBuildInputs = [
  ];

  configurePhase = ''
    cmake -B build/windows \
      -DCMAKE_SYSTEM_NAME="Windows" \
      -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
      -DCMAKE_ASM_COMPILER_TARGET="x86_64-windows-gnu" \
      -DCMAKE_C_COMPILER_TARGET="x86_64-windows-gnu" \
      -DCMAKE_CXX_COMPILER_TARGET="x86_64-windows-gnu"
  '';

  buildPhase = ''
    cmake --build build/windows
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv build/windows/src/game.* $out/bin
  '';
}
