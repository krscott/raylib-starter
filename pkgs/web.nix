{
  appName,
  raylib-src,
  callPackage,
  emscripten,
}:
callPackage ./base.nix rec {
  platform = "web";

  inherit raylib-src;

  nativeBuildInputs = [
    emscripten
  ];

  configurePhase = ''
    ./web-configure.sh
  '';

  buildPhase = ''
    ./web-build.sh
  '';

  installPhase = ''
    mkdir -p $out/share
    mv build/${platform}/src/${appName}* $out/share/
  '';
}
