{
  description = "Configuration Nix";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }:
  let
    system = "x86_64-linux";
    stateVersion = "25.05";

    envConfig = builtins.fromJSON (builtins.readFile ./env.json);

    # nixpkgsConfig = {
    #   allowUnfree = true;
    # };



    hardwareConfig = ./hardware-configuration.nix;
    systemConfig = ./modules/system;
    environmentDesktop = ./modules/environments/${envConfig.environment}.nix;
    homeManagerConfig = ./modules/home;

    specialArgs = {
      pkgs-unstable = nixpkgs-unstable;
      state-version = stateVersion;
      env-config = envConfig;
    };
  in
  {
    nixosConfigurations = {
      ${envConfig.hostname} = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
            modules = [
              hardwareConfig
              systemConfig

              # configuration

              environmentDesktop

              # Home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${envConfig.username} = homeManagerConfig;
              }
            ];
          };
    };
  };
}
