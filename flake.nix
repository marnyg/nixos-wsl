{
  description = "A very basic flake";
  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs, nixos-wsl }: {
    #nixosModules.wsl = {
    tst.moduels = {
      imports = nixos-wsl;
    };

    nixosConfigurations.mysystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        nixos-wsl = nixos-wsl;
      };
      modules = [
        ./configuration.nix
      ];
    };

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
