{
  description = "alan's nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
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
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, ... }:
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
          ({ lib, config, pkgs, ... }: 
          {
            imports = [
              home-manager.nixosModules.home-manager
              (import ./boxes/lithium-desktop.nix {
                inherit pkgs lib nixpkgs nixpkgs-unstable home-manager;
              })
              (import ./common/flake-conf.nix {
                inherit pkgs nixpkgs nixpkgs-unstable;
              })
              (import ./common/localisation.nix)
            ];
            nixpkgs.overlays = [ overlay-unstable ];
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowBroken = true;

            system.configurationRevision =
              nixpkgs.lib.mkIf (self ? rev) self.rev;
            nix.registry.nixpkgs.flake = nixpkgs;
          })
        ];
      };
      nixosConfigurations.pi-server = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ({ lib, config, pkgs, ... }: {
            imports = [
              home-manager.nixosModules.home-manager
              nixos-hardware.nixosModules.raspberry-pi-4

              # INCOMPLETE

              (import ./common/flake-conf.nix {
                inherit pkgs nixpkgs nixpkgs-unstable;
              })
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
