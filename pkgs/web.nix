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
    (
      cd build/${platform}/src/
      mv *.html *.js *.wasm $out/share/www
    )
  '';
}
