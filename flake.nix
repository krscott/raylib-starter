{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    raylib-src = {
      url = "github:raysan5/raylib";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    raylib-src,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in
    flake-utils.lib.eachSystem supportedSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        pkgArgs = {inherit raylib-src;};
      in {
        packages = {
          default = self.packages.${system}.native;
          native = pkgs.callPackage ./pkgs/native.nix pkgArgs;
          windows = pkgs.callPackage ./pkgs/windows.nix pkgArgs;
        };

        devShells = {
          default = pkgs.mkShell {
            inputsFrom = [self.packages.${system}.native];
            nativeBuildInputs = [
              # add dev pkgs
            ];
          };
        };

        formatter = pkgs.alejandra;
      }
    );
}
