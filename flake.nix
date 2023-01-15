{
  description = "A very basic flake";
  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    #my-nixos.url = "git+file:///home/nixos/git/nixos";
    my-nixos.url = "github:marnyg/nixos/wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, my-nixos, home-manager }: {
    nixosConfigurations.mysystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        nixos-wsl = nixos-wsl;
      };
      modules = [
        ./configuration.nix

        #import system module
        my-nixos.nixosModules
        {
          #enable system module
          modules.syncthing.enable = true;
          #modules.tailscale-autoconnect.enable =true;
        }

        #import home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #home-manager.extraSpecialArgs = { inherit username; };
          #home-manager.users.nixos.imports = [ (import ./home.nix) ] ++ [ (import ./madoka/home.nix) ];
          home-manager.users.nixos.imports = [
            #import home manager modules
            #  { config, lib, pkgs, username, ... }:
            {
              programs.home-manager.enable = true;

              programs.keychain.enable = true;
              programs.keychain.enableZshIntegration = true;

              programs.direnv.enable = true;
              programs.direnv.enableZshIntegration = true;

              services.lorri.enable = true;

              home = {
                username = "nixos";
                homeDirectory = "/home/nixos";
                stateVersion = "22.05";

                file.".config/nixpkgs/config.nix" = {
                  text = ''
                    { allowUnfree = true; }
                  '';
                };

                #sessionPath = [
                #  "$HOME/go/bin"
                #  "$HOME/.local/bin"
                #  "$HOME/bin"
                #];
              };
            }
            my-nixos.homeManagerModules
            {
              #modules.firefox.enable = true;
              modules.zsh.enable = true;
              modules.dunst.enable = true;
              # enable home manager modules
            }
          ];
        }
      ];
    };
  };
}
