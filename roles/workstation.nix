{ pkgs, hardware, home-manager, ... }: 
{
	imports = [ 
		./subroles/printer.nix
		./subroles/pipewire.nix
		./subroles/vmware.nix
		./subroles/gaming.nix
	];

	users.users.alan = {
		description = "Alan,,,alan@alnn.xyz";
		isNormalUser = true;
		extraGroups = [ "wheel" "adbusers" ];
		initialPassword = "sexo";
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
	environment.defaultPackages = [];
	environment.systemPackages = with pkgs; [
		# Browser
		unstable.librewolf
		unstable.ungoogled-chromium
		# System utilities
		git
		vim
		unstable.libstrangle
		python39Full python39Packages.pip
		ark rar
		plasma-systemmonitor
		wineWowPackages.stagingFull
		# Media
		qbittorrent
		flameshot
		qimgv
		obs-studio
		# Work
		libreoffice-qt
		vscode-fhs
		# Virtualisation
		qemu_full
	];

	virtualisation.libvirtd.enable = true;

	programs.java = {
		enable = true;
		package = with pkgs; adoptopenjdk-jre-openj9-bin-16;
	};

	# ADB
	programs.adb.enable = true;
}
