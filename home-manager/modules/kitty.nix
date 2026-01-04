{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;

      enable_audio_bell = false;
      confirm_os_window_close = 0;

      background_opacity = "0.92";

      cursor_shape = "beam";
      mouse_hide_wait = 2;
    };

    extraConfig = ''
      map ctrl+shift+enter new_window
      map ctrl+shift+t new_tab
    '';
  };
}