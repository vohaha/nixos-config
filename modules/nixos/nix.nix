# Nix daemon, nixpkgs policy, and the nh helper.
{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/home/vh/nixos-config"; # sets $NH_FLAKE
    clean = {
      enable = true; # systemd timer; replaces manual nix-collect-garbage
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
