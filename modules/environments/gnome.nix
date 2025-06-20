{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      displayManager = {
        gdm = {
          enable = true;
        };
      };

      desktopManager = {
        gnome = {
          enable = true;
        };

        xterm = {
          enable = false;
        };
      };

      excludePackages = with pkgs; [
        xterm
      ];
    };
  };

  environment = {
    systemPackages = with pkgs.gnomeExtensions; [
      dash-to-dock
      appindicator
    ];

    gnome.excludePackages = with pkgs; [
      epiphany
      geary
      totem
      tali
      iagno
      hitori
      atomix
      yelp
      packagekit

      gnome-tour
      gnome-software
      gnome-contacts
      gnome-user-docs
      gnome-packagekit
      gnome-font-viewer
    ];
  };


  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Paramètres GNOME
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  programs.dconf = {
    enable = true;

    profiles.gdm.databases = [
      {
        settings = {
          # Pavé numérique lors de la connexion
          "org/gnome/desktop/peripherals/keyboard" = {
            numlock-state = true;
          };
        };
      }
    ];

    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
            focus-mode = "click";
            visual-bell = false;
          };

          # Pavé numérique une fois connecté
          "org/gnome/desktop/peripherals/keyboard" = {
            numlock-state = true;
          };

          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              "dash-to-dock@micxgx.gmail.com"
              "appindicatorsupport@rgcjonas.gmail.com"
            ];
          };

          "org/gnome/shell/extensions/dash-to-dock" = {
            click-action = "minimize-or-overview";
            disable-overview-on-startup = true;
            dock-position = "BOTTOM";
            running-indicator-style = "DOTS";
            isolate-monitor = false;
            multi-monitor = true;
            show-mounts-network = true;
            always-center-icons = true;
            custom-theme-shrink = true;
          };
        };
      }
    ];
  };

}
