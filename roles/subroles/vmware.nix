{ pkgs, ... }:
{
	nixpkgs.overlays = [
		(self: super: {
			vmware-workstation = super.vmware-workstation.overrideAttrs (oldAttrs: rec {
				installPhase = oldAttrs.installPhase ++ "\nrm $out/lib/vmware/libconf/etc/fonts/fonts.conf";
			});
		})
	];

	virtualisation.vmware.host.enable = true;
}
