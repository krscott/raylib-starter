{
  appName,
  raylib-src,
  callPackage,
  emscripten,
}:
callPackage ./base.nix rec {
  platform = "web";

  inherit appName raylib-src;

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
    mkdir -p $out/share/${appName}-${platform}
    mv build/${platform}/src/${appName}* $out/share/${appName}-${platform}
  '';
}
