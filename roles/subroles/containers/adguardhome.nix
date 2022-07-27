{ pkgs, ... }:
{
	networking.firewall.allowedTCPPorts = [ 53 ];
	networking.nat.internalInterfaces = [ "ve-adguard" ];

	services.nginx.enable = true;
	services.nginx.virtualHosts."alnn.xyz" = {
		locations."/agh/".proxyPass = "http://localhost:3001";
	};

	containers.adguard = {
		config = { config, pkgs, ... }: {
			system.stateVersion = "22.05";
			
			services.unbound = {
				enable = true;
				settings.server = {
					interface = [ "127.0.0.1" ];
					port = 52;
					do-ip4 = true;
					do-ip6 = false;
					do-udp = true;
					do-tcp = true;

					prefetch = true;
					num-threads = 1;
					so-rcvbuf = "1m";
				};
			};

			services.adguardhome = {
				enable = true;
				host = "127.0.0.1";
				port = 3000;
				settings = {
					tls = {
						enabled = true;
						server_name = "";
						force_https = false;
						port_https = 0;
						port_dns_over_tls = 0;
						port_dns_over_quic = 0;
						port_dnscrypt = 0;
						strict_sni_check = false;
						allow_unencrypted_doh = true;
					};
					dns = {
						port = 53;
						bootstrap_dns = "9.9.9.9";
						upstream_dns = [ "127.0.0.1:52" ];
						bind_host = "0.0.0.0";
						trusted_proxies = [ "127.0.0.1" ];
					};
				};
			};
		};
		autoStart = true;
		privateNetwork = true; 
		forwardPorts = [
			{
				containerPort = 3000;
				hostPort = 3001;
				protocol = "tcp";
			}
			{
				containerPort = 53;
				hostPort = 53;
				# Both TCP and UDP is required, but I'm not sure how to do this
				protocol = "tcp";
			}
		];
		bindMounts = {
			"/var/lib/unbound" = {
				hostPath = "/var/lib/unbound";
				isReadOnly = false;
			};
			"/var/lib/AdGuardHome" = {
				hostPath = "/var/lib/AdGuardHome";
				isReadOnly = false;
			};
		};
	};
}
