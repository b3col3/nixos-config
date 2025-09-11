{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      # dev
      devbox
      gcc
      nil
      nixd
      nixfmt-rfc-style
      rustup
      zed-editor

      # utilitaire
      discord
      qbittorrent
      vlc
    ];
  };
}
