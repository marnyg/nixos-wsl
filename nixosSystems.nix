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
        home-manager.nixosModules.home-manager  
        ./homemanagerConfig.nix
      ];
    };
}
