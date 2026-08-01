# Hyprland session tooling: bar, notifications, lock/idle, clipboard,
# screenshots. Hyprland itself is enabled system-wide (modules/nixos/desktop.nix);
# its own config lives in ~/.config/hypr/hyprland.lua and is still mutable.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    grim # screenshot
    slurp # region select
    wl-clipboard # wl-copy / wl-paste
    pavucontrol # audio mixer GUI
    playerctl # media keys
    brightnessctl # backlight / monitor brightness
  ];

  # Notification daemon.
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-radius = 8;
      padding = "10";
    };
  };

  # Clipboard history (query with `cliphist list`).
  services.cliphist.enable = true;

  # Idle -> lock -> screen off.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 600; # 10 min -> lock
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 900; # 15 min -> screen off
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general.hide_cursor = true;
      background = [{ color = "rgba(1a1a1aff)"; }];
      input-field = [{
        size = "300, 50";
        position = "0, -80";
        halign = "center";
        valign = "center";
        outline_thickness = 2;
      }];
    };
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "cpu" "memory" "network" "tray" ];

      clock = {
        format = "{:%a %d %b  %H:%M}";
        tooltip-format = "<tt>{calendar}</tt>";
      };
      cpu.format = "󰻠 {usage}%";
      memory.format = "󰍛 {percentage}%";
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        on-click = "pavucontrol";
      };
      network = {
        format-wifi = "󰤨 {essid}";
        format-ethernet = "󰈀 wired";
        format-disconnected = "󰤭 offline";
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(26, 26, 26, 0.9);
        color: #e0e0e0;
      }
      #workspaces button.active { background: #3b4252; }
      #clock, #cpu, #memory, #network, #pulseaudio, #tray {
        padding: 0 10px;
      }
    '';
  };
}
