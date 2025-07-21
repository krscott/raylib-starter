{
  appName,
  raylib-src,
  callPackage,
  pkgsCross,
}:
callPackage ./base.nix {
  inherit (pkgsCross.mingwW64) stdenv;

  platform = "windows";
  mainProgram = "${appName}.exe";

  inherit appName raylib-src;
}
