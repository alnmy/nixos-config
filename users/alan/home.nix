{ pkgs, ... }:
{
	imports = [
		./packages/mpv/default.nix
		./packages/syncthing/default.nix
	];

	programs.home-manager.enable = true;

	home.username = "alan";
	home.homeDirectory = "/home/alan";

	home.stateVersion = "22.05";

	# XDG
	xdg.mimeApps.enable = true;
	xdg.mimeApps.defaultApplications = 
	let
		webBrowser = [ "chromium-browser.desktop" ];
		imageViewer = [ "qimgv.desktop" ];
		torrentClient = [ "org.qbittorrent.qBittorrent.desktop" ];
	in
	{
		"text/html" = webBrowser;
		"x-scheme-handler/http" = webBrowser;
		"x-scheme-handler/https" = webBrowser;
		"x-scheme-handler/about" = webBrowser;
		"x-scheme-handler/unknown" = webBrowser;

		"image/webp" = imageViewer;
		"image/png" = imageViewer;
		"image/jpeg" = imageViewer;
		"image/gif" = imageViewer;
		"image/bmp" = imageViewer;

		"application/x-bittorrent" = torrentClient;
		"x-scheme-handler/magnet" = torrentClient;
	};

	home.packages = with pkgs; [
		# Editors
		unstable.kate

		# Formatters
		shellcheck
		nixfmt

		# Media
		ff2mpv
		cmus
		qimgv
		qbittorrent
	];
}
