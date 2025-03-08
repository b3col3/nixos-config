{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs-unstable.follows = "nixos-cosmic/nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      ...
    }@inputs:
    let
      system = import ./core/system.nix { inherit nixpkgs inputs; };
    in
    {
      nixosConfigurations.wsl = system {
        name = "wsl";
        system = "x86_64-linux";
        stateVersion = "24.11";
        user = "nixos";
        isWsl = true;
      };

      nixosConfigurations.dell-inspirion = system {
        name = "dell-inspirion";
        system = "x86_64-linux";
        stateVersion = "24.11";
        user = "b3col3";
        desktop = "hyprland";
        isWsl = false;
      };
    };
}
