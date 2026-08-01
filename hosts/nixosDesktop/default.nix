# nixosDesktop — AMD desktop, btrfs root.
{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/base.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/users.nix
  ];

  networking.hostName = "nixosDesktop";

  # Hardware specific to this machine.
  hardware.cpu.amd.updateMicrocode = true;
  services.xserver.videoDriver = [ "amdgpu" ];

  zramSwap.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  # The NixOS release this machine was first installed with. Never bump this
  # casually — see `man configuration.nix`. It does not affect package versions.
  system.stateVersion = "26.05";
}
