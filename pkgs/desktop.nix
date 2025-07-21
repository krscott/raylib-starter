{
  appName,
  raylib-src,
  callPackage,
  libGL,
  xorg,
}:
callPackage ./base.nix {
  platform = "desktop";
  mainProgram = appName;

  inherit appName raylib-src;

  nativeBuildInputs = [
    libGL
    xorg.libX11
    xorg.libX11.dev
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
  ];
}
