{ pkgs, hardware, home-manager, ... }: 
{
	imports = [ 
		./subroles/printer.nix
		./subroles/pipewire.nix
		./subroles/vmware.nix
	];

	users.users.alan = {
		description = "Alan,,,alan@alnn.xyz";
		isNormalUser = true;
		extraGroups = [ "wheel" "adbusers" ];
	};

	# Home-manager
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
	programs.steam.enable = true;

	# Firewall
	networking.firewall.enable = true;
	# Open ports for KDE-Connect
	networking.firewall = {
		allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
		allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
	};

	# Desktop
	services.xserver.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;	
	services.xserver.displayManager.sddm.enable = true;

	# Fonts
	fonts.fonts = with pkgs; [ 
		unstable.cozette
	];

	# Packages
	environment.defaultPackages = [];
	environment.systemPackages = with pkgs; [
		# Browser
		unstable.librewolf
		unstable.ungoogled-chromium
		# System utilities
		git
		vim
		unstable.libstrangle
		ark rar
		plasma-systemmonitor
		# Games
		mindustry
		unstable.polymc
		mangohud
		# Media
		qbittorrent
		flameshot
		qimgv
		# Work
		libreoffice-qt
	];

	programs.java = {
		enable = true;
		package = with pkgs; adoptopenjdk-jre-openj9-bin-16;
	};

	# ADB
	programs.adb.enable = true;
}
