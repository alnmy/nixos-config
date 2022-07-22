{ config, pkgs, ... }: {
	system.stateVersion = "22.05";
	
	services.ddclient.enable = true;
}
