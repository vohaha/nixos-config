# User accounts. Per-user packages and dotfiles live under ../../home.
{ ... }:

{
  users.users.vh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo
  };
}
