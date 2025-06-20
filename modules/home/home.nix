{ state-version, env-config, ... }:

{
  home = {
    username = env-config.username;
    homeDirectory = "/home/${env-config.username}";

    stateVersion = state-version;
  };
}
