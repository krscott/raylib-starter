{
  raylib-src,
  callPackage,
  pkgsCross,
}:
callPackage ./base.nix {
  inherit (pkgsCross.mingwW64) stdenv;

  platform = "windows";
  mainProgram = "game.exe";

  inherit raylib-src;

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
}
