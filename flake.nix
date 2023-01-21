{
  description = "A very basic flake";
  inputs = {
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    my-nixos.url = "git+file:///home/nixos/git/nixos";
    #my-nixos.url = "github:marnyg/nixos/wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, my-nixos, home-manager }: {
    nixosConfigurations = import ./nixosSystems.nix { inherit nixpkgs my-nixos home-manager nixos-wsl; };
    devShells = import ./flakeFuntions/shell.nix { inherit nixpkgs; };
    checks = import ./flakeFunctions/checks.nix { inherit nixpkgs; };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
