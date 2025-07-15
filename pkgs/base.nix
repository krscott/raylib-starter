{
  mainProgram ? "game",
  platform,
  nativeBuildInputs,
  configurePhase,
  buildPhase,
  raylib-src,
  stdenv,
  lib,
  cmake,
}:
stdenv.mkDerivation {
  name = "raylib-starter-${platform}";
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

  inherit configurePhase buildPhase;

  installPhase = ''
    mkdir -p $out/bin
    mv build/${platform}/src/${mainProgram} $out/bin/
  '';

  meta = {
    inherit mainProgram;
  };
}
