{ pkgs, ... }:
{
    networking.firewall.allowedTCPPorts = [ 22 ];
    services.openssh = {
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = false;
        extraConfig = ''
            AllowTcpForwarding yes
            AllowAgentForwarding no
            AllowStreamLocalForwarding no
            AuthenticationMethods publickey
        '';
    };
}
