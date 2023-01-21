{ nixpkgs, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
in
{
  "${system}".default = pkgs.mkShell {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    nativeBuildInputs = with pkgs; [
      nixpkgs-fmt
      shfmt
      rustc
      cargo
      rustfmt
      clippy
    ];
  };
}
