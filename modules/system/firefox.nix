{
  programs = {
    firefox = {
      enable = true;
      wrapperConfig.pipewireSupport = true;

      languagePacks = [
        "fr"
        "en-US"
      ];

      preferences = {
        "intl.accept_languages" = "fr-fr,en-us,en";
        "intl.locale.requested" = "fr,en-US";
        "browser.sessionstore.max_resumed_crashes" = "0";
      };
    };
  };
}
