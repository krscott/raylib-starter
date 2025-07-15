{
  suffix,
  nativeBuildInputs,
  configurePhase,
  buildPhase,
  installPhase,
  raylib-src,
  stdenv,
  lib,
  cmake,
}:
stdenv.mkDerivation {
  name = "raylib-starter-${suffix}";
  src = lib.cleanSource ./..;

  nativeBuildInputs =
    [
      cmake
    ]
    ++ nativeBuildInputs;

  installRaylibPhase = ''
    ln -s ${raylib-src} lib/raylib
  '';

  patchShScripts = ''
    patchShebangs *.sh
  '';

  preConfigurePhases = [
    "installRaylibPhase"
    "patchShScripts"
  ];

  inherit configurePhase buildPhase installPhase;
}
