{
  description = "Derek's nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      persepliquis = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };

    homeConfigurations."derek" = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;

       # Specify your home configuration modules here, for example,
       # the path to your home.nix.
       modules = [ ./home.nix ];

       # Optionally use extraSpecialArgs
       # to pass through arguments to home.nix
    };
  };

}

