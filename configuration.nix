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
  #environment.systemPackages = with pkgs; [ zellij ];
  users.users.nixos = {   
    shell = pkgs.bash;
  };
  systemd.services.foo = {
    script = ''
      mkdir -p /home/nixos/git;
      ${pkgs.git}/bin/git clone https://github.com/marnyg/nixos-modules /home/nixos/git/nixos-modules;
      ${pkgs.git}/bin/git clone https://github.com/marnyg/nixos-wsl /home/nixos/git/nixos-wsl;
      ${pkgs.git}/bin/git clone https://github.com/marnyg/nixos /home/nixos/git/nixos;
      ${pkgs.git}/bin/git clone https://github.com/marnyg/nvim-conf /home/nixos/git/nvim;
    '';
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
  };


  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.11";
}
