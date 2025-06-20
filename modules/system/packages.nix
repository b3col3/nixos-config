{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      discord
      nil
      nixd
      nixfmt-rfc-style
      qbittorrent
      vlc
      zed-editor
    ];
  };
}
