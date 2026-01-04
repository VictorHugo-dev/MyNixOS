{ config, pkgs, ... }:

{

  imports = [
  	./modules/kitty.nix
	./modules/nwg-bar.nix
	./modules/nvim.nix
  ];

  home.username = "victor";
  home.homeDirectory = "/home/victor";
  home.stateVersion = "25.11";
  
  home.sessionVariables = {
  	XDG_DATA_DIRS = "$HOME/.local/share/flatpak/exports/share:var/lib/flatpak/exports/share:/usr/share";
  };

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;
  xdg.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.whitesur-cursors;
    name = "WhiteSur-cursors";
    size = 24;
  };

  gtk.enable = true;

  gtk.colorScheme = "dark";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    google-chrome

    kitty
    waybar
    rofi
    mako
    hyprpaper

    grim

    playerctl
    pavucontrol
    networkmanagerapplet
    blueman
    parted

    nwg-look
    nwg-bar
    gtk-layer-shell

    whitesur-cursors
    whitesur-icon-theme

    nemo
    fastfetch

    discord
    flatpak

    nerd-fonts.jetbrains-mono
    roboto
  ];

  services.mako.enable = true;

  programs.waybar.enable = true;
  programs.kitty.enable = true;

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  xdg.configFile."hypr/hyprland.conf".text = ''
    $mod = SUPER

    monitor = ,preferred,auto,1

    exec-once = waybar
    exec-once = mako
    exec-once = nm-applet
    exec-once = blueman-applet
    exec-once = hyprpaper

    input {
      kb_layout = br
      follow_mouse = 1
    }

    general {
      gaps_in = 4
      gaps_out = 8
      border_size = 2
    }

    bind = $mod, Return, exec, kitty
    bind = $mod, D, exec, rofi -show drun -display-drun ""
    bind = $mod, E, exec, nemo
    bind = $mod, Q, killactive,
    bind = $mod, V, togglefloating,
    bind = $mod, F, fullscreen,
    bind = $mod, M, exit,
    bind = $mod, left, movefocus, l
    bind = $mod, right, movefocus, r
    bind = $mod, up, movefocus, u
    bind = $mod, down, movefocus, d
    bind = $mod, P, exec, grim

    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod, 0, workspace, 10

    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = $mod SHIFT, 0, movetoworkspace, 10

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
  '';

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/victor/Pictures/Wallpaper.png
    wallpaper = ,/home/victor/Pictures/Wallpaper.png
  '';

  xdg.configFile."waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 32,
      "spacing": 10,

      "modules-left": [
        "custom/apple",
        "hyprland/workspaces"
      ],

      "modules-center": [
        "hyprland/window"
      ],

      "modules-right": [
        "network",
        "pulseaudio",
        "clock"
      ],

      "custom/apple": {
        "format": "󰀵",
        "tooltip": false,
        "on-click": "rofi -show drun"
      },

      "hyprland/workspaces": {
        "format": "{name}",
        "persistent-workspaces": {
          "*": 5
        }
      },

      "hyprland/window": {
        "format": "{title}",
        "max-length": 70,
        "separate-outputs": true
      },

      "network": {
        "format-wifi": "󰖩  {signalStrength}%",
        "format-ethernet": "󰈀",
        "format-disconnected": "󰖪",
        "tooltip-format-wifi": "{essid} {ipaddr}"
      },

      "pulseaudio": {
        "format": "󰕾  {volume}%",
        "format-muted": "󰖁 Muted",
        "on-click": "pavucontrol"
      },

      "backlight": {
        "format": "󰃟  {percent}%",
        "on-scroll-up": "brightnessctl set +5%",
        "on-scroll-down": "brightnessctl set 5%-"
      },

      "clock": {
        "format": "󰥔  {:%a %b %d  %H:%M}",
        "tooltip-format": "{:%Y-%m-%d %H:%M:%S}"
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "Roboto Black", "JetBrainsMono Nerd Font";
      font-size: 12px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(24, 24, 28, 0.65);
      border: 1px solid rgba(255, 255, 255, 0.10);
      border-radius: 14px;
      color: #f2f2f7;
      padding: 0 10px;
    }

    #custom-apple {
      padding: 0 10px;
      margin: 4px 6px 4px 6px;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.06);
    }

    #workspaces {
      margin: 4px 6px;
      padding: 2px 6px;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.06);
    }

    #workspaces button {
      padding: 0 8px;
      margin: 0 2px;
      border-radius: 10px;
      color: #f2f2f7;
      background: transparent;
    }

    #workspaces button.active {
      background: rgba(255, 255, 255, 0.18);
    }

    #window {
      margin: 4px 6px;
      padding: 0 10px;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.06);
    }

    #network, #bluetooth, #pulseaudio, #backlight, #clock, #tray {
      margin: 4px 4px;
      padding: 0 10px;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.06);
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      icon-theme: "WhiteSur";
      drun-display-format: "{name}";
      matching: "fuzzy";
      sort: true;
      case-sensitive: false;
      cycle: true;
      sidebar-mode: false;
    }

    @theme "spotlight"
  '';

  xdg.configFile."rofi/themes/spotlight.rasi".text = ''
    * {
      font: "JetBrainsMono Nerd Font 15";

      background: transparent;
      foreground: #e9e9ea;

      bg0: rgba(30, 30, 32, 0.92);
      bg1: rgba(255, 255, 255, 0.06);
      bg2: rgba(255, 255, 255, 0.16);

      fg0: #e9e9ea;
      fg1: rgba(233, 233, 234, 0.72);

      radius0: 18px;
      radius1: 12px;
    }

    window {
      location: center;
      anchor: center;
      fullscreen: false;
      width: 720px;

      background-color: @bg0;
      border: 0px;
      border-radius: @radius0;
      padding: 18px;
    }

    mainbox {
      background-color: transparent;
      spacing: 14px;
      padding: 0px;
      children: [ inputbar, listview ];
    }

    inputbar {
      background-color: @bg1;
      border-radius: @radius1;
      padding: 14px 16px;
      spacing: 10px;
      children: [ prompt, entry ];
    }

    prompt {
      enabled: true;
      text-color: @fg1;
    }

    entry {
      background-color: transparent;
      text-color: @fg0;
      placeholder: "Search";
      placeholder-color: @fg1;
    }

    listview {
      background-color: transparent;
      columns: 1;
      lines: 6;
      fixed-height: false;
      spacing: 8px;
      scrollbar: false;
    }

    element {
      background-color: transparent;
      border-radius: @radius1;
      padding: 10px 12px;
      spacing: 12px;
      text-color: @fg0;
      children: [ element-icon, element-text ];
    }

    element selected {
      background-color: @bg2;
      text-color: @fg0;
    }

    element-icon {
      background-color: transparent;
      size: 1.4em;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
    }
  '';
}
