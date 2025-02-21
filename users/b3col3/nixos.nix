{ user, ... }:

{ pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };
}
