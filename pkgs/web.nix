{
  useZig ? false,
  appName,
  raylib-src,
  callPackage,
  emscripten,
}:
callPackage ./base.nix rec {
  platform = "web";

  inherit appName raylib-src useZig;

  nativeBuildInputs = [
    emscripten
  ];

  installPhase = ''
    mkdir -p $out/share/www
    mv build/${platform}/src/${appName}* $out/share/www
  '';
}
