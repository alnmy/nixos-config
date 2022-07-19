{ pkgs, lib, nixpkgs, nixpkgs-unstable, ... }:

{
	imports = [ 
		../hardware/desktop.nix 
		../roles/workstation.nix 
	];
	
	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot = {
			enable = true;
			configurationLimit = 30;
			editor = false;
		};
	};

	networking = {
		hostName = "lithium-desktop";
		hostId = "e4b670ed";
		domain = "alnn.xyz";		

		enableIPv6 = false;
		useDHCP = false;

		defaultGateway = "192.168.1.254";
		nameservers = [ "192.168.1.65" ];

		interfaces.enp4s0.ipv4.addresses = [{
			address = "192.168.1.100";
			prefixLength = 24;
		}];
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-label/boot";
		fsType = "vfat";
	};

	fileSystems."/" = {
		device = "/dev/pool/root";
		fsType = "xfs";
	};
}
