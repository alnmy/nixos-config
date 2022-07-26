{ pkgs, ... }: 
{
	users.users.alan = {
		description = "Alan,,,alan@alnn.xyz";
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = (import ../secrets/secrets.nix null).alan;
	};

	nix.trustedUsers = [ "root" "alan" ];

	# OpenSSH
	services.openssh.enable = true;
	services.openssh.passwordAuthentication = false;
	services.openssh.permitRootLogin = "no";

	# systemd-resolved for caching DNS requests
	services.resolved = {
		enable = true;
		dnssec = "allow-downgrade";
	};

	# Firewall
	networking.firewall = {
		enable = true;
		allowPing = false;
		# Services should automatically unblock the ports they need 
		allowedTCPPorts = [
			80 443
			22
			53
		];
		allowedUDPPorts = [
			53
		];
	};

	# Packages
	environment.systemPackages = with pkgs; [
		# System utilities
		git
		vim
		screen
	];

	# DDClient container
	age.secrets.ddclient = {
		file = ../secrets/ddclient.age;
		path = "/etc/ddclient.conf";
	};

	containers.ddclient = {
		config = import ./subroles/containers/ddclient.nix;
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
