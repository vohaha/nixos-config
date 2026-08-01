# Networking and remote access.
{ ... }:

{
  # Configure connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
