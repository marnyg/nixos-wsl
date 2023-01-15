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

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.11";

  #  services.tailscale.enable = true;
  #  services.tailscale.port = 12345;
  #
  #  systemd.services.tailscale-autoconnect = {
  #    description = "Automatic connection to Tailscale";
  #
  #    # make sure tailscale is running before trying to connect to tailscale
  #    after = [ "network-pre.target" "tailscale.service" ];
  #    wants = [ "network-pre.target" "tailscale.service" ];
  #    wantedBy = [ "multi-user.target" ];
  #
  #    # set this service as a oneshot job
  #    serviceConfig.Type = "oneshot";
  #
  #    # have the job run this shell script
  #    script = with pkgs; ''
  #      # wait for tailscaled to settle
  #      sleep 2
  #
  #      # check if we are already authenticated to tailscale
  #      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
  #      if [ $status = "Running" ]; then # if so, then do nothing
  #        exit 0
  #      fi
  #
  #      # otherwise authenticate with tailscale
  #      ${tailscale}/bin/tailscale up -authkey xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  #      # ${tailscale}/bin/tailscale up -authkey tskey-kNoFRv2CNTRL-6XQhDpk6odhiMUimcQYhf
  #    '';
  #  };

}
