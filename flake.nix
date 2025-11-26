{
  description = "DevShell for second2050.me";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      eachSystem =
        f: lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          name = "website";
          packages = [
            pkgs.hugo
            pkgs.vscode-langservers-extracted # htmlls, cssls
            pkgs.ltex-ls-plus
            pkgs.imagemagick
          ];
        };
      });
    };
}
