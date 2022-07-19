let
	alan = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCid1330p7W+mFXGNzupll6YL9euOQZ1kMoDeVkoG9AFUFercfKbFiio6CEIiUTkn7sV64yv7kWn/o9BQ4Y9uPr9fXFNbEVY4T+/ioDT00YCJkY+iaHSwyr8Zl4tEvyFFhGH4u/TdPdbbo1AIQeBImnBb9Kow8vtOmnrnmb1DZowHk+DOe7AH+LS2bkbu19EFdLwHY4p3hjHJautz2VYcoh1wHXqI+ZOTg2GjTtjogP1SrpfBugL8glAIG+d/Il2kEsxNeVE8D8T8HP0VdNs0Vcl9ed4etczmNNA1Q/vOf3pMWx+XZhk+v+0AFovswwp6az2w3lx8Zhc7SXd84cQA+4ImZtecUC/Ces8MC7FZQeiqr7Oet9+1WMFXCGG0ptNxfZufaQfNW7MqRnt8wdIKHkxfkzvzkmxNOelA9AOQlhiko5g+hhS82pY4u37maYXtdTJRT4mS+FLJn+so73gUpUEswjrInaTtSnqLMIwLOkP7GJWpUyGpHj0AtBw+qwvWE= alan@nix";
	users = [ alan ];
	
	pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOIZ5Y+7kK3Un4vMMKRphY9JzRUhUhMSxkhqq7J5a4l root@nixos";
	systems = [ pi ];
in
{
	# TODO: actually use agenix, and use more than just my public key for the secret files.
	"secret1.age".publicKeys = [ alan ];
}
