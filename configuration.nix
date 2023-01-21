{ pkgs, config, nixos-wsl, modulesPath, ... }:

{
  imports = [
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };

  #enable system module
  #modules.syncthing.enable = true;
  #modules.firefox.enable = true;
  #modules.zsh.enable = true;
  #modules.dunst.enable = true;
  #modules.tailscale-autoconnect.enable =true;

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.11";
}
