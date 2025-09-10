{
  programs = {
    zed-editor = {
      enable = true;

      extensions = ["nix" "toml" "Material Theme"];

      userSettings = {
        hour_format = "hour24";

        terminal = {
          shell = "system";
          working_directory = "current_project_directory";
        };

        theme = {
          mode = "system";
          light = "Material Theme Darker High Contrast";
          dark = "Material Theme Darker High Contrast";
        };
        show_whitespaces = "all" ;
        ui_font_size = 16;
        buffer_font_size = 16;

        lsp = {
          rust-analyzer = {
            binary = {
              #  path = lib.getExe pkgs.rust-analyzer;
              path_lookup = true;
              };
          };
          nix = {
            binary = {
              path_lookup = true;
            };
          };
        };
      };


    };
  };
}
