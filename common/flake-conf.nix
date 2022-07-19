{ nixpkgs, nixpkgs-unstable, pkgs, ... }: {
    system.stateVersion = "22.05";

    nix.registry = {
        nixpkgs.flake = nixpkgs;
        nixpkgs-unstable.flake = nixpkgs-unstable;
    };

    nix.package = pkgs.nixFlakes;
    nix.extraOptions = "experimental-features = nix-command flakes";
}
