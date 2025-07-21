{
  appName,
  mainProgram ? null,
  platform,
  nativeBuildInputs ? [],
  configurePhase ? null,
  buildPhase ? null,
  installPhase ? null,
  raylib-src,
  stdenv,
  lib,
  cmake,
}: let
  withDefault = default: val:
    if val != null
    then val
    else default;
in
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

    configurePhase =
      withDefault ''
        ./configure.sh ${platform}
      ''
      configurePhase;

    buildPhase =
      withDefault ''
        ./build.sh ${platform}
      ''
      buildPhase;

    installPhase =
      withDefault ''
        mkdir -p $out/bin
        mv build/${platform}/src/${mainProgram} $out/bin/
      ''
      installPhase;

    shellHook = ''
      if [[ -f lib/raylib ]]; then
        rm lib/raylib
      fi
      if ! [[ -e lib/raylib ]]; then
        ln -s ${raylib-src} lib/raylib
      fi

      if ! [[ -f .clangd ]]; then
        cp .clangd-example .clangd
      fi
    '';

    meta = {
      inherit mainProgram;
    };
  }
