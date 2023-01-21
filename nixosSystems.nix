{ nixpkgs, nixos-wsl, my-nixos, home-manager }:
{
  mysystem = nixpkgs.lib.nixosSystem
    {
      system = "x86_64-linux";
      specialArgs = {
        nixos-wsl = nixos-wsl;
        home-manager = home-manager;
        inherit my-nixos;
      };
      modules = [
        ./configuration.nix
        my-nixos.nixosModules
        #./homemanager.nix
        #home-manager.nixosModules.home-manager  (import ./homemanager.nix {inherit  home-manager  my-nixos;})
        #import ./home-manager { inherit home-manager; }
        #my-nixos.homeManagerModules
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          #home-manager.extraSpecialArgs = { inherit username; };
          #home-manager.users.nixos.imports = [ (import ./home.nix) ] ++ [ (import ./madoka/home.nix) ];
          home-manager.users.nixos.imports = [
            my-nixos.homeManagerModules
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
          ];
        }
      ];
    };
}
