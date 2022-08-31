{ config, ... }:
{
	xdg.mimeApps = {
		defaultApplications = let
			mpv = [ "mpv.desktop" ];
		in
		{
			"application/mxf" = mpv;
			"application/sdp" = mpv;
			"application/smil" = mpv;
			"application/streamingmedia" = mpv;
			"application/vnd.apple.mpegurl" = mpv;
			"application/vnd.ms-asf" = mpv;
			"application/vnd.rn-realmedia" = mpv;
			"application/vnd.rn-realmedia-vbr" = mpv;
			"application/x-cue" = mpv;
			"application/x-extension-m4a" = mpv;
			"application/x-extension-mp4" = mpv;
			"application/x-matroska" = mpv;
			"application/x-mpegurl" = mpv;
			"application/x-ogg" = mpv;
			"application/x-ogm" = mpv;
			"application/x-ogm-audio" = mpv;
			"application/x-ogm-video" = mpv;
			"application/x-shorten" = mpv;
			"application/x-smil" = mpv;
			"application/x-streamingmedia" = mpv;
			"audio/3gpp" = mpv;
			"audio/3gpp2" = mpv;
			"audio/aac" = mpv;
			"audio/ac3" = mpv;
			"audio/aiff" = mpv;
			"audio/AMR" = mpv;
			"audio/amr-wb" = mpv;
			"audio/dv" = mpv;
			"audio/eac3" = mpv;
			"audio/flac" = mpv;
			"audio/m3u" = mpv;
			"audio/m4a" = mpv;
			"audio/mp1" = mpv;
			"audio/mp2" = mpv;
			"audio/mp3" = mpv;
			"audio/mp4" = mpv;
			"audio/mpeg" = mpv;
			"audio/mpeg2" = mpv;
			"audio/mpeg3" = mpv;
			"audio/mpegurl" = mpv;
			"audio/mpg" = mpv;
			"audio/musepack" = mpv;
			"audio/ogg" = mpv;
			"audio/opus" = mpv;
			"audio/rn-mpeg" = mpv;
			"audio/scpls" = mpv;
			"audio/vnd.dolby.heaac.1" = mpv;
			"audio/vnd.dolby.heaac.2" = mpv;
			"audio/vnd.dts" = mpv;
			"audio/vnd.dts.hd" = mpv;
			"audio/vnd.rn-realaudio" = mpv;
			"audio/vorbis" = mpv;
			"audio/wav" = mpv;
			"audio/webm" = mpv;
			"audio/x-aac" = mpv;
			"audio/x-adpcm" = mpv;
			"audio/x-aiff" = mpv;
			"audio/x-ape" = mpv;
			"audio/x-m4a" = mpv;
			"audio/x-matroska" = mpv;
			"audio/x-mp1" = mpv;
			"audio/x-mp2" = mpv;
			"audio/x-mp3" = mpv;
			"audio/x-mpegurl" = mpv;
			"audio/x-mpg" = mpv;
			"audio/x-ms-asf" = mpv;
			"audio/x-ms-wma" = mpv;
			"audio/x-musepack" = mpv;
			"audio/x-pls" = mpv;
			"audio/x-pn-au" = mpv;
			"audio/x-pn-realaudio" = mpv;
			"audio/x-pn-wav" = mpv;
			"audio/x-pn-windows-pcm" = mpv;
			"audio/x-realaudio" = mpv;
			"audio/x-scpls" = mpv;
			"audio/x-shorten" = mpv;
			"audio/x-tta" = mpv;
			"audio/x-vorbis" = mpv;
			"audio/x-vorbis+ogg" = mpv;
			"audio/x-wav" = mpv;
			"audio/x-wavpack" = mpv;
			"application/ogg" = mpv;
			"video/3gp" = mpv;
			"video/3gpp" = mpv;
			"video/3gpp2" = mpv;
			"video/avi" = mpv;
			"video/divx" = mpv;
			"video/dv" = mpv;
			"video/fli" = mpv;
			"video/flv" = mpv;
			"video/mkv" = mpv;
			"video/mp2t" = mpv;
			"video/mp4" = mpv;
			"video/mp4v-es" = mpv;
			"video/mpeg" = mpv;
			"video/msvideo" = mpv;
			"video/ogg" = mpv;
			"video/quicktime" = mpv;
			"video/vnd.divx" = mpv;
			"video/vnd.mpegurl" = mpv;
			"video/vnd.rn-realvideo" = mpv;
			"video/webm" = mpv;
			"video/x-avi" = mpv;
			"video/x-flc" = mpv;
			"video/x-flic" = mpv;
			"video/x-flv" = mpv;
			"video/x-m4v" = mpv;
			"video/x-matroska" = mpv;
			"video/x-mpeg2" = mpv;
			"video/x-mpeg3" = mpv;
			"video/x-ms-afs" = mpv;
			"video/x-ms-asf" = mpv;
			"video/x-msvideo" = mpv;
			"video/x-ms-wmv" = mpv;
			"video/x-ms-wmx" = mpv;
			"video/x-ms-wvxvideo" = mpv;
			"video/x-ogm" = mpv;
			"video/x-ogm+ogg" = mpv;
			"video/x-theora" = mpv;
			"video/x-theora+ogg" = mpv;
		};
	};

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
