{ config, pkgs, ... }:

{
  home.username = "vh";
  home.homeDirectory = "/home/vh";

  # User packages, moved here from users.users.vh.packages.
  home.packages = with pkgs; [
    tree
    ghostty
    zed-editor
    brave
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "vohaha";
      user.email = "dev@volodymyrkondratenko.com";
      init.defaultBranch = "main";
    };
  };

  # Let home-manager manage itself.
  programs.home-manager.enable = true;

  # Like system.stateVersion: set once at first install, do not bump casually.
  home.stateVersion = "26.05";
}
