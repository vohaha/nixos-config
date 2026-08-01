# User accounts. Per-user packages and dotfiles live under ../../home.
{ ... }:

{
  users.users.vh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBqUVrUu7Dd5ErD2tKh8laD7lkqVuteSlZKtF72TyMaI"
    ];
  };
}
