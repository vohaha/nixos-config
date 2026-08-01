# Baseline CLI environment present on every host.
{ pkgs, ... }:

{
  # neovim for the user lives in home/vh/neovim.nix. vim stays here so root
  # and rescue shells always have a usable editor.

  # Run dynamically-linked binaries that aren't packaged for nix.
  programs.nix-ld.enable = true;

  environment.shellAliases = {
    # Rebuild/GC are handled by `nh os switch` and the programs.nh.clean timer.
    ned = "$EDITOR /home/vh/nixos-config";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    claude-code
  ];
}
