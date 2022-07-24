{ pkgs, hardware, home-manager, ... }: 
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

	# Fonts
	fonts.fonts = with pkgs; [ 
		unstable.cozette
	];

	# Packages
	environment.systemPackages = with pkgs; [
		# System utilities
		git
		vim
		pkgs.unstable.libstrangle
		# Games
		mindustry
		# Media
		qbittorrent	
	];

	programs.java = {
		enable = true;
		package = with pkgs; adoptopenjdk-jre-openj9-bin-16;
	};
}
