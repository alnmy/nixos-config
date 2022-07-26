{ pkgs, ... }:
{
    networking.firewall.allowedTCPPorts = [ 6697 443 80 ];
    networking.nat.internalInterfaces = [ "ve-soju" ];

    services.nginx.enable = true;
    services.nginx.virtualHosts."bouncer.alnn.xyz" = {
        serverName = "bouncer.alnn.xyz";
        enableACME = true;
        addSSL = true;
    };

    containers.soju = {
        config = { config, pkgs, ... }:
        {
            system.stateVersion = "22.05";

            services.soju = {
                enable = true;
                enableMessageLogging = true;

                hostName = "bouncer.alnn.xyz";
                listen = [ ":6697" ];

                tlsCertificate = "/var/lib/soju/acme/cert.pem";
                tlsCertificateKey = "/var/lib/soju/acme/key.pem";
            };
        };
        autoStart = true;
        privateNetwork = true;
        forwardPorts = [{
            containerPort = 6697;
            hostPort = 6697;
            protocol = "tcp";
        }];
        bindMounts = {
            "/var/lib/soju/acme/" = {
                hostPath = "/var/lib/acme/bouncer.alnn.xyz/";
                isReadOnly = true;
            };
        };
    };
}
