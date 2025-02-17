{
  description = "Very light version of FluidSynth designed to be hardware, platform and external dependency independent.";

  inputs = {
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
      pkgsFor = eachSystem (system: inputs.nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachSystem (system: {
        default = pkgsFor.${system}.mkShell {
          nativeBuildInputs = with pkgsFor.${system}; [
            pkg-config
            cmake
          ];
        };
      });

      packages = eachSystem (system: {
        default = pkgsFor.${system}.callPackage ./package.nix { };
      });
    };
}
