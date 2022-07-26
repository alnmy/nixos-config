{ pkgs, ... }:
{
	age.secrets.ddclient = {
		file = ../../../secrets/ddclient.nix;
		path = "/etc/ddclient.conf";
	};

	containers.ddclient = {
		config = { config, pkgs, ... }: {
			system.stateVersion = "22.05";

			services.ddclient.enable = true;
			services.ddclient.configFile = "/etc/ddclient.conf";
		};
		autoStart = true;
		privateNetwork = false;
		bindMounts = {
			"/etc/ddclient.conf" = {
				hostPath = "/etc/ddclient.conf";
				isReadOnly = true;
			};
		};
	};
}
