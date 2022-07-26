{ lib, pkgs, ... }:

{
	# Boot splash screen
	boot.plymouth.enable = true;

	# Hardware support 
	boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	boot.kernelModules = [ "kvm-amd" "hid_apple" ];	
	boot.supportedFilesystems = [ "ntfs" ];

	# Build options
	nix.settings.max-jobs = 8;

	# Power management
	powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";

	# CPU microcode
	hardware.enableRedistributableFirmware = true;
	hardware.cpu.amd.updateMicrocode = true; 

	# Proprietary NVIDIA Drivers
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"nvidia-x11"
	];
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;
	
	# Mouse input
	services.xserver.libinput = {
		enable = true;
		mouse.accelProfile = "flat";
	};
	
	# Apple keyboard
	services.xserver = { 
		xkbModel = "mac";
		layout = "gb";
	};
	console.useXkbConfig = true;
	boot.extraModprobeConfig = ''
		options hid_apple fnmode=2
		options hid_apple swap_opt_cmd=1
	'';
	services.udev.extraHwdb = ''
		evdev:input:b0003v05AC*
			KEYBOARD_KEY_c00b8=sysrq	# Eject Key
			KEYBOARD_KEY_70068=insert	# F13 Key
	'';

	# Bluetooth
	hardware.bluetooth.enable = true;
}
