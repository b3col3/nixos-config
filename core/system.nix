{ nixpkgs, inputs }:

{
  name,
  system,
  stateVersion,
  user,
  isWsl ? false,
}:

let
  machineConfig = ../machines/${name}.nix;
  userOsConfig = ../users/${user}/nixos.nix;
  userHomeManagerConfig = ../users/${user}/home-manager.nix;

  home-manager = inputs.home-manager.nixosModules.home-manager;

in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    (if isWsl then inputs.nixos-wsl.nixosModules.wsl else { })

    (import machineConfig { stateVersion = stateVersion; })
    userOsConfig
    home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHomeManagerConfig {
        stateVersion = stateVersion;
        isWsl = isWsl;
        inputs = inputs;
      };
    }

    # Exportation de quelques arguments supplémentaire pour les modules
    {
      config._module.args = {
        currentSystem = system;
        currentStateVersion = stateVersion;
        currentSystemName = name;
        currentSystemUser = user;
        isWsl = isWsl;
        inputs = inputs;
      };
    }
  ];
}
