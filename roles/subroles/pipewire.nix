{ config, pkgs, nix-gaming, ... }:
{
	# rtkit gives real-time scheduling priority to PipeWire
	security.rtkit.enable = true;

	# Bluetooth sound configuration
	environment.etc = {
		"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
			bluez_monitor.properties = {
				["bluez5.enable-sbc-xq"] = true,
				["bluez5.enable-msbc"] = true,
				["bluez5.enable-hw-volume"] = true,
				["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
			}
		'';
	};

	services.pipewire = {
		enable = true;

		# Compability layers
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;

		# Low latency
		lowLatency.enable = true;
	};
}
