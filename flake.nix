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

    # CMakeLists.txt project name
    appName = "raylib-starter";
  in
    flake-utils.lib.eachSystem supportedSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        pkgArgs = {
          inherit appName raylib-src;
        };
      in {
        packages = {
          default = self.packages.${system}.desktop;
          desktop = pkgs.callPackage ./pkgs/desktop.nix pkgArgs;
          windows = pkgs.callPackage ./pkgs/windows.nix pkgArgs;
          web = pkgs.callPackage ./pkgs/web.nix pkgArgs;
          webserver = pkgs.writeShellScriptBin "webserver" ''
            cd "${self.packages.${system}.web}/share/${appName}-web"
            ${pkgs.lib.getExe pkgs.python3} -m http.server
          '';
        };

        apps = {
          web = flake-utils.lib.mkApp {drv = self.packages.${system}.webserver;};
        };

        devShells = {
          default = pkgs.mkShell {
            inputsFrom = [self.packages.${system}.desktop];
            nativeBuildInputs = [
              # add dev pkgs
            ];
          };
        };

        formatter = pkgs.alejandra;
      }
    );
}
