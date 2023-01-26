{ nixpkgs, nixos-wsl, my-nixos, home-manager, my-nvim }:
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
        {
          modules.myNvim.enable=true;
        }
        my-nvim.nixosModule2."x86_64-linux"
        my-nixos.nixosModules
        home-manager.nixosModules.home-manager  
        ./homemanagerConfig.nix
      ];
    };
}
