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

	boot.initrd.postDeviceCommands = lib.mkAfter ''
		zfs rollback -r nixos/local/root@blank
	'';

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

	# Mount points 
	fileSystems = let
		ntfsOptions = [ "rw" "user" "exec" "uid=1000" "gid=1000" "umask=000" ];
	in
	{
		"/boot" = {
			device = "/dev/disk/by-label/boot";
			fsType = "vfat";
		};

		"/" = {
			device = "nixos/local/root";
			fsType = "zfs";
		};
		"/nix" = {
			device = "nixos/local/nix";
			fsType = "zfs";
		};
		"/persist" = {
			device = "nixos/safe/persist";
			fsType = "zfs";
		};

		"/home" = {
			device = "nixos/safe/home";
			fsType = "zfs";
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

	# Persistance
	systemd.tmpfiles.rules = [
		"L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
		"L /etc/nixos - - - - /persist/etc/nixos"
	];

	services.openssh = {
		hostKeys = [
		{
			path = "/persist/ssh/ssh_host_ed25519_key";
			type = "ed25519";
		}
		{
			path = "/persist/ssh/ssh_host_rsa_key";
			type = "rsa";
			bits = 4096;
		}
		];
	};	
}
