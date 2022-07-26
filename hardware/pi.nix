{ lib, pkgs, ... }:

{
	# Kernel
	boot.kernelPackages = pkgs.linuxPackages_rpi4;
	boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
	boot.kernelParams = [
		"console=tty1"
		"quiet"
	];

	# Power management
	powerManagement.cpuFreqGovernor = "ondemand";

	# Wireless Firmware 
	hardware.enableRedistributableFirmware = true;

	# Bootloader
	boot.loader = {
		raspberryPi.enable = false;
		grub.enable = false;
		generic-extlinux-compatible.enable = true;
	};
}
