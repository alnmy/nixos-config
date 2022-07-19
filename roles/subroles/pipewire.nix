{ config, pkgs, ... }:
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

		# Low latency configuration
		config.pipewire = {
			"context.properties" = {
				"link.max-buffers" = 16;
				"log.level" = 2;
				"default.clock.rate" = 48000;
				"default.clock.quantum" = 32;
				"default.clock.min-quantum" = 32;
				"default.clock.max-quantum" = 32;
				"core.daemon" = true;
				"core.name" = "pipewire-0";
			};
			"context.modules" = [
				{
					name = "libpipewire-module-rtkit";
					args = {
						"nice.level" = -15;
						"rt.prio" = 88;
						"rt.time.soft" = 200000;
						"rt.time.hard" = 200000;
					};
					flags = [ "ifexists" "nofail" ];
				}
				{ name = "libpipewire-module-protocol-native"; }
				{ name = "libpipewire-module-profiler"; }
				{ name = "libpipewire-module-metadata"; }
				{ name = "libpipewire-module-spa-device-factory"; }
				{ name = "libpipewire-module-spa-node-factory"; }
				{ name = "libpipewire-module-client-node"; }
				{ name = "libpipewire-module-client-device"; }
				{
					name = "libpipewire-module-portal";
					flags = [ "ifexists" "nofail" ];
				}
				{
					name = "libpipewire-module-access";
					args = {};
				}
				{ name = "libpipewire-module-adapter"; }
				{ name = "libpipewire-module-link-factory"; }
				{ name = "libpipewire-module-session-manager"; }
			];
		};
		# Low latency configuration for Pulse backend
		config.pipewire-pulse = {
			"context.properties" = {
				"log.level" = 2;
			};
			"context.modules" = [
				{
					name = "libpipewire-module-rtkit";
					args = {
						"nice.level" = -15;
						"rt.prio" = 88;
						"rt.time.soft" = 200000;
						"rt.time.hard" = 200000;
					};
					flags = [ "ifexists" "nofail" ];
				}
				{ name = "libpipewire-module-protocol-native"; }
				{ name = "libpipewire-module-client-node"; }
				{ name = "libpipewire-module-adapter"; }
				{ name = "libpipewire-module-metadata"; }
				{
					name = "libpipewire-module-protocol-pulse";
					args = {
						"pulse.min.req" = "32/48000";
						"pulse.default.req" = "32/48000";
						"pulse.max.req" = "32/48000";
						"pulse.min.quantum" = "32/48000";
						"pulse.max.quantum" = "32/48000";
						"server.address" = [ "unix:native" ];
					};
				}
			];
			"stream.properties" = {
				"node.latency" = "32/48000";
				"resample.quality" = 1;
			};
		};
	};
}