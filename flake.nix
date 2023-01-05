{
  description = "alan's nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      flake = false;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.agenix.inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager
    , agenix, nix-gaming, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = self: super: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          config.allowBroken = true;
        };
      };
    in {
      nixosConfigurations.lithium-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({ lib, config, pkgs, ... }: {
            imports = [
              agenix.nixosModules.age
              home-manager.nixosModules.home-manager
              nix-gaming.nixosModules.pipewireLowLatency
              (import ./boxes/lithium-desktop.nix {
                inherit pkgs lib nixpkgs nixpkgs-unstable home-manager nix-gaming;
              })
              (import ./common/flake-conf.nix {
                inherit pkgs nixpkgs nixpkgs-unstable;
              })
              (import ./common/cachix.nix)
              (import ./common/localisation.nix)
            ];
            nixpkgs.overlays = [ overlay-unstable ];
            nixpkgs.config.allowUnfree = true;

            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
          })
        ];
      };
    };
}
