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
  machine-config = ../machines/${name}.nix;
  user-os-config = ../users/${user}/nixos.nix;
  user-home-manager-config = ../users/${user}/home-manager.nix;

  cosmic-desktop-config = ../modules/cosmic-desktop.nix;

  home-manager = inputs.home-manager.nixosModules.home-manager;

in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    (if isWsl then inputs.nixos-wsl.nixosModules.wsl else { })

    (
      if desktop == "cosmic" then
        (import cosmic-desktop-config {
          inputs = inputs;
        })
      else
        { }
    )

    machine-config
    (import user-os-config { user = user; })

    home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import user-home-manager-config {
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
