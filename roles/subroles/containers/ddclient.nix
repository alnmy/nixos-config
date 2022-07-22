{ config, pkgs, ... }:
{
	system.stateVersion = "22.05";
	
	config.age.secrets.ddclient.file = ../../../secrets/ddclient.age;
			
	services.ddclient = {
		enable = true;
		domains = [ "@" ];
		interval = "1min";
		use = "web, web=dynamicdns.park-your-domain.com/getip";
		protocol = "namecheap";
		server = "dynamicdns.park-your-domain.com";
		username = "alnn.xyz";
		passwordFile = config.age.secrets.ddclient.path;
	};
}
