# Hyprland session, login manager, and desktop-facing apps.
{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  security.polkit.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # tray applet + GUI pairing

  services.displayManager.gdm.enable = false;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
      user = "greeter";
    };
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wofi
    tuigreet
    bitwarden-desktop
  ];
}
