{ config, pkgs, ... }:
{
	services.printing = {
		enable = true;
		drivers = with pkgs; [ brlaser ];
		tempDir = "/tmp/cups";
			
		webInterface = true;
		
		# Automatically find and add printers (https://discourse.nixos.org/t/printers-they-work/17545/2)
		browsing = true;
		browsedConf = ''
			BrowseDNSSDSubTypes _cups,_print
			BrowseLocalProtocols all
			BrowseRemoteProtocols all
			CreateIPPPrinterQueues All
		'';		
	};
	
	services.avahi = {
		enable = true;
		nssmdns = true;
	};
}
