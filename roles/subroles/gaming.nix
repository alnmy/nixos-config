{ pkgs, config, ... }:
{
	programs.steam.enable = true;

	environment.systemPackages = with pkgs; [
		mangohud
		prismlauncher
	]; 
}
