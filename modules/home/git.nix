{ env-config, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = env-config.git.username;
      userEmail = env-config.git.email;

      extraConfig = {
        credential.helper = "store";
      };
    };
  };
}
