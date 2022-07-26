{ pkgs, lib, nixpkgs, nixpkgs-unstable, ... }:

{
	imports = [ 
		../hardware/pi.nix 
		../roles/server.nix 
	];
	
	networking = {
		hostName = "pi-server";
		hostId = "9e794156";
		domain = "alnn.xyz";		

		enableIPv6 = false;
		useDHCP = false;

		defaultGateway = "192.168.1.254";
		nameservers = [ "localhost" ];

		interfaces.enp4s0.ipv4.addresses = [{
			address = "192.168.1.65";
			prefixLength = 24;
		}];
	};

	fileSystems."/" = {
		device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
		fsType = "ext4";
	};

	swapDevices = [ { device = "/swapfile"; size = 8192; } ];
}
