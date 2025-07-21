{
  appName,
  mainProgram ? null,
  platform,
  nativeBuildInputs ? [],
  configurePhase,
  buildPhase,
  installPhase ? null,
  raylib-src,
  stdenv,
  lib,
  cmake,
}:
stdenv.mkDerivation {
  name = "${appName}-${platform}";
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

  installPhase =
    if installPhase == null
    then ''
      mkdir -p $out/bin
      mv build/${platform}/src/${mainProgram} $out/bin/
    ''
    else installPhase;

  shellHook = ''
    if [[ -f lib/raylib ]]; then
      rm lib/raylib
    fi
    if ! [[ -e lib/raylib ]]; then
      ln -s ${raylib-src} lib/raylib
    fi
  '';

  meta = {
    inherit mainProgram;
  };
}
