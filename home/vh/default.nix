{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zed.nix
  ];

  home.username = "vh";
  home.homeDirectory = "/home/vh";

  home.packages = with pkgs; [
    tree
    ghostty
    brave
  ];

  programs.home-manager.enable = true;

  # Like system.stateVersion: set once at first install, do not bump casually.
  home.stateVersion = "26.05";
}
