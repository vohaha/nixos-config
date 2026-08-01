{ pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./ghostty.nix
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./zed.nix
  ];

  home.username = "vh";
  home.homeDirectory = "/home/vh";

  programs.brave.enable = true;

  home.packages = with pkgs; [ tree ];

  programs.home-manager.enable = true;

  # Like system.stateVersion: set once at first install, do not bump casually.
  home.stateVersion = "26.05";
}
