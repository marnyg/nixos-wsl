{ home-manager, my-nixos, ... }:
{
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
};
}

