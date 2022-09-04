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

	swapDevices = [ { device = "/swapfile"; size = 8192; } ];

	# Mount points 
	fileSystems = let
		ntfsOptions = [ "rw" "user" "exec" "uid=1000" "gid=1000" "umask=000" ];
	in
	{
		"/" = {
			device = "/dev/pool/root";
			fsType = "xfs";
		};
		"/boot" = {
			device = "/dev/disk/by-label/boot";
			fsType = "vfat";
		};

		"/mnt/hdd" = {
			device = "/dev/disk/by-label/HDD";
			fsType = "ntfs";
			options = ntfsOptions;
		};
		"/mnt/hdd2" = {
			device = "/dev/disk/by-label/HDD2";
			fsType = "ntfs";
			options = ntfsOptions;
		};
	};
}
