{ lib, pkgs, nixos-hardware, ... }:

{
	# Kernel
	boot.kernelPackages = pkgs.linuxPackages_rpi4;
	boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
	boot.kernelParams = [
		"console=tty1"
		"quiet"
	];

	# Build options
	nix = {
		settings = {
			max-jobs = 2;
			cores = lib.mkDefault config.nix.settings.max-jobs;
		};
	};

	# Power management
	powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

	# Wireless Firmware 
	hardware.enableRedistributableFirmware = true;

	# Bootloader
	boot.loader = {
		raspberryPi.enable = false;
		grub.enable = false;
		generic-extlinux-compatible.enable = true;
	};

	# Swap file
	swapDevices = [ { device = "/swapfile"; size = 8192; }];
}
