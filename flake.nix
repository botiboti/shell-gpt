{
  description = "shell-gpt";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        py-pkgs = pkgs.python3Packages;
      in {
        packages = rec {
          default = py-pkgs.buildPythonPackage {
            name = "shell_gpt";
            version = "1.1.0";
            format = "pyproject";
            src = pkgs.fetchFromGitHub {
              owner = "TheR1D";
              repo = "shell_gpt";
              rev = "1.1.0";
              sha256 = "sha256-F7sq/uckLxC5nrhOZ6xyfmh8zOCcJxspiGa9CVns2tE=";
            };
            propagatedBuildInputs = with py-pkgs; [
              hatchling
              typer
              requests
              click
              rich
              distro
              openai
            ];
          };
        };
      });
}
