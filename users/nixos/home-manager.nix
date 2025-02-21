{ isWsl, inputs, ... }:

{
  config,
  lib,
  pkgs,
  ...
}:

{
  home = {
    stateVersion = "24.05";

    username = "nixos";
    homeDirectory = "/home/nixos";

    packages = with pkgs; [
      gh
      go
      nixfmt-rfc-style
    ];

    # sessionVariables = {
    #   GOPROXY = "";
    # };
  };

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      # interactiveShellInit = lib.strings.concatStrings (
      #   lib.strings.intersperse "\n" ([
      #     "set fish_greeting" # Disable greeting
      #     (builtins.readFile ./config.fish)
      #     "set -g SHELL ${pkgs.fish}/bin/fish"
      #   ])
      # );

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    #   interactiveShellInit = ''
    #     set fish_greeting # Disable greeting
    #   '';

    #   shellAliases = {
    #     ll = "ls -la";
    #     update = "sudo nixos-rebuild switch";

    #     # navigation shortcuts
    #     ".." = "cd ..";
    #     "..." = "cd ../../";
    #     "...." = "cd ../../../";
    #     "....." = "cd ../../../../";

    #     # git shortcuts
    #     ga = "git add .";
    #     gc = "git commit";
    #     gapa = "git add --patch";
    #     grpa = "git reset --patch";
    #     gst = "git status";
    #     gdh = "git diff HEAD";
    #     gp = "git push";
    #     gph = "git push -u origin HEAD";
    #     gco = "git checkout";
    #     gcob = "git checkout -b";
    #     gcm = "git checkout master";
    #     gcd = "git checkout develop";
    #     gsp = "git stash push -m";
    #     gsa = "git stash apply stash";
    #     gsl = "git stash list";
    #   };
    # };

    git = {
      enable = true;
      userName = "";
      userEmail = "";

      extraConfig = {
        credential.helper = "store";
      };
    };
  };
}
