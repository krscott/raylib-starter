{
  raylib-src,
  callPackage,
  libGL,
  xorg,
}:
callPackage ./base.nix {
  suffix = "linux";

  inherit raylib-src;

  nativeBuildInputs = [
    libGL
    xorg.libX11
    xorg.libX11.dev
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
  ];

  configurePhase = ''
    ./desktop-configure.sh
  '';

  buildPhase = ''
    ./desktop-build.sh
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv build/desktop/src/game $out/bin
  '';
}
