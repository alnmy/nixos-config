let
	alan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbObAoVSAHbjVV0hW5YpTevSnrvGpZleBVrSI87trcL alnn@box";
	users = [ alan ];
	
	pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOIZ5Y+7kK3Un4vMMKRphY9JzRUhUhMSxkhqq7J5a4l root@nixos";
	lithium-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXfkLOdpHx7QvCjpmwuJo21OJJD1C3ylhgSSZhenKtU root@lithium-desktop";
	systems = [ pi ];
in
{
	# TODO: actually use agenix, and use more than just my public key for the secret files.
	"secret1.age".publicKeys = [ alan ];
}
