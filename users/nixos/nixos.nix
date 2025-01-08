{ pkgs, lib, ... }:

{
  programs = {
    fish = {
      enable = true;

      # interactiveShellInit = ''
      #   set fish_greeting # Disable greeting
      # '';
    };
  };

  users.users.nixos = {
    isNormalUser = true;
    # home = "/home/nixos";
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;

    # openssh.authorizedKeys.keys = [ ];
  };

  environment.shellAliases = lib.mkForce {
    ll = "ls -la";
    update = "sudo nixos-rebuild switch";

    # navigation shortcuts
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    # git shortcuts
    ga = "git add .";
    gapa = "git add --patch";
    grpa = "git reset --patch";
    gst = "git status";
    gdh = "git diff HEAD";
    gp = "git push";
    gph = "git push -u origin HEAD";
    gco = "git checkout";
    gcob = "git checkout -b";
    gcm = "git checkout master";
    gcd = "git checkout develop";
    gsp = "git stash push -m";
    gsa = "git stash apply stash";
    gsl = "git stash list";
  };
}
