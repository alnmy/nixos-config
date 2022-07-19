{ pkgs, hardware, home-manager, agenix, ... }: 
{
	imports = [ 
		./subroles/printer.nix
		./subroles/pipewire.nix
	];

	users.users.alan = {
		description = "Alan,,,alan@alnn.xyz";
		isNormalUser = true;
		extraGroups = [ "wheel" ];
	};

	home-manager.useGlobalPkgs = true;
	home-manager.users.alan = ../users/alan/home.nix;

	nix.trustedUsers = [ "root" "alan" ];

	# OpenSSH
	services.openssh.enable = true;
	services.openssh.passwordAuthentication = false;

	# systemd-resolved for caching DNS requests
	services.resolved = {
		enable = true;
		dnssec = "allow-downgrade";
	};

	# GnuPG agent
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	# Games
	hardware.opengl.driSupport32Bit = true;
	programs.steam.enable = true;

	# Firewall
	networking.firewall.enable = true;

	# Desktop
	services.xserver.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;	
	services.xserver.displayManager.sddm.enable = true;

	# Packages
	environment.systemPackages = with pkgs; [
		# System utilities
		git
		vim
		agenix.defaultPackage.x86_64-linux
		# Games
		mindustry
		# Media
		qbittorrent	
	];
}
