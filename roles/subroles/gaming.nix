{ pkgs, config, ... }:
{
	programs.steam.enable = true;

	environment.systemPackages = with pkgs; [
		unstable.polymc
		mangohud
	]; 
}
