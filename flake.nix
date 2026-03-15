{
  description = "Wine gaming environment for running Windows games on Linux";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # packages.${system}.default = pkgs.buildEnv {
      #   name = "wine-gaming";
      #   paths = with pkgs; [
      #     wineWow64Packages.stable
      #     winetricks
      #   ];
      # };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          wineWow64Packages.staging
          winetricks
          cabextract
          python3
          gamescope
          fuseiso
        ];
        shellHook = ''
          echo "🍷 Wine Gaming Environment (Staging)"
        '';
      };
    };
}
