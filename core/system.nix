{ nixpkgs, inputs }:

{
  name,
  system,
  stateVersion,
  user,
  desktop ? "none",
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

    (
      if desktop == "cosmic" then
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
          # inputs.nixos-cosmic.nixosModules.default
        }
      else
        { }
    )

    (import machineConfig { stateVersion = stateVersion; })
    (import userOsConfig { user = user; })
    home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHomeManagerConfig {
        stateVersion = stateVersion;
        user = user;
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
