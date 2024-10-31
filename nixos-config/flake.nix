{
  description = "Derek's nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, wezterm, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      persepliquis = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
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
       modules = [ 
         ./hyprland.nix
         ./home.nix
       ];

       # Optionally use extraSpecialArgs
       # to pass through arguments to home.nix
       extraSpecialArgs = { inherit inputs; };
    };
  };

}

