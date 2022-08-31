{ pkgs, ... }:
{
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
	];

	# Chromium
	programs.chromium = {
		enable = true;
		package = pkgs.ungoogled-chromium;
	};

	# KDE Connect
	services.kdeconnect.enable = true;

	# MPV
	programs.mpv = {
		enable = true;
		package = pkgs.mpv; 
		bindings = {
			LEFT = "seek -0.4";
			RIGHT = "seek 0.4";

			"-" = "add volume -5";
			"=" = "add volume +5";

			# UOSC
			MBTN_RIGHT = "script-binding uosc/menu"; # Menu
			o = "script-binding uosc/open-file"; # Open
			"Ctrl+s" = "script-binding uosc/subtitles"; # Subtitles
			"Ctrl+a" = "script-binding uosc/audio"; # Audio
			"Ctrl+p" = "script-binding uosc/playlist"; # Playlist
			"Ctrl+l" = "cycle-values loop-file \"inf\" \"no\""; # Loop
			"Ctrl+r" = "script-message reload_resume"; # Reload
			"Ctrl+i" = "script-binding stats/display-stats"; # Display stats
			"Ctrl+c" = "script-binding uosc/open-config-directory"; # Open configuration directory
		};
		config = {
			volume = 50;
			volume-max = 100;

			# video
			profile ="gpu-hq";
			hwdec = "nvdev-copy";
			icc-profile-auto = "";

			# window
			keep-open = "";
			force-window = "immediate";
		};
		profiles = {
			WEB = {
				profile-cond = "string.match(get(\"filename\", \"\"), \"WEBRip\")==nil and (string.match(get(\"filename\", \"\"), \"WEB\")~=nil or string.match(get(\"filename\", \"\"), \"%.web%.\")~=nil)";
				profile-restore = "copy-equal";
				deband-iterations = 2;
				deband-threshold = 35;
				deband-range = 20;
				deband-grain = 5;
			};
			DVD = {
				profile-cond = "string.match(get(\"filename\", \"\"), \"DVD\")==nil";
				deband-iterations = 3;
				deband-threshold = 45;
				deband-range = 25;
				deband-grain = 15;
			};
			"extension.gif" = {
				loop-file = "";
			};
			https = {
				profile-cond = "p[\"demuxer-via-network\"]==true and string.match(get(\"path\", \"\"), \"^https?://\")~=nil";
				profile = "WEB";
			};
			"protocol.ytdl" = {
				profile = "WEB";
			};
		};
	};
}
