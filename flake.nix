{
  description = "Learn Lean4 flaked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    lean.url = github:leanprover/lean4;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, lean, flake-utils }: flake-utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = import nixpkgs { inherit system; };

        leanPkgs = lean.packages.${system};

        pkg = leanPkgs.buildLeanPackage {
          name = "Main";  # must match the name of the top-level .lean file
          src = ./src;
        };
      in {
        packages = pkg // { inherit (leanPkgs) lean; };

        defaultPackage = pkg.modRoot;

        devShell = pkgs.mkShell {
          buildInputs = [
            leanPkgs.lean
          ];

          shellHook = ''
            export LEAN_PATH="$PWD/result"
            export LEAN_SRC_PATHc="$PWD/src"
          '';
        };
      }
    );
}
