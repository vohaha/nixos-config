{
  description = "NixOS configuration";

  inputs = {
    # Unstable channel. To track a stable release instead, swap nixos-unstable
    # for a release number (e.g. nixos-25.05). `nix flake update` to refresh.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager master tracks nixpkgs-unstable; the follows keeps both
    # evaluating against the exact same nixpkgs revision.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixosDesktop = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/nixosDesktop

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Rename pre-existing dotfiles to *.backup instead of failing
          # activation when home-manager takes ownership of them.
          home-manager.backupFileExtension = "backup";
          home-manager.users.vh = import ./home/vh;
        }
      ];
    };
  };
}
