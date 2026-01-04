{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nwg-bar
  ];

  xdg.configFile."nwg-bar/bar.json".text = builtins.toJSON {
    layer = "top";
    position = "top";
    height = 34;
    margin = 6;

    icon_size = 22;
    icon_theme = "WhiteSur";

    css_file = "${config.xdg.configHome}/nwg-bar/style.css";

    buttons_left = [ ];

    buttons_right = [
      {
        label = "Power";
        icon = "system-shutdown";
        command = "sh -lc 'choice=$(printf \"Lock\\nLogout\\nSuspend\\nHibernate\\nReboot\\nShutdown\\n\" | rofi -dmenu -i -p \"Power\"); case \"$choice\" in Lock) loginctl lock-session ;; Logout) loginctl terminate-user \"$USER\" ;; Suspend) systemctl suspend ;; Hibernate) systemctl hibernate ;; Reboot) systemctl reboot ;; Shutdown) systemctl poweroff ;; esac'";
      }
    ];
  };

  xdg.configFile."nwg-bar/style.css".text = ''
    window {
      background-color: rgba(24, 24, 28, 0.65);
      border: 1px solid rgba(255, 255, 255, 0.10);
      border-radius: 14px;
      padding: 6px;
    }

    button {
      background-color: rgba(255, 255, 255, 0.06);
      border-radius: 10px;
      margin: 4px;
      padding: 6px 10px;
      color: #f2f2f7;
    }

    button:hover {
      background-color: rgba(255, 255, 255, 0.14);
    }
  '';
}