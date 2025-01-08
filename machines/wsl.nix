{ pkgs, currentSystemUser, ... }:

{

  wsl = {
    enable = true;
    # wslConf.automount.root = "/mnt";
    # defaultUser = currentSystemUser;
    # startMenuLaunchers = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };

  environment = {
    systemPackages = with pkgs; [ wget ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
