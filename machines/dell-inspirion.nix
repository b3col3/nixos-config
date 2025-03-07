{
  imports = [
    ./hardware/dell-inspirion-hardware.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "dell-inspirion";

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "fr";
      variant = "azerty";
    };

    printing.enable = true;
  };
}
