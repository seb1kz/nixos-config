{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # lub Twoja wersja nixpkgs

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, silentSDDM, ... }@inputs: {
    nixosConfigurations.seb = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        silentSDDM.nixosModules.default
      ];
    };
  };
}
