{ lib, inputs, nixpkgs, home-manager, username, ... }:

let
  system = "x86_64-linux";  
  pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  lib = nixpkgs.lib;
in
{
  homura = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs username; };
    modules = [
      ./homura
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit username; };
        home-manager.users.${username}.imports = [(import ./home.nix)] ++ [(import ./homura/home.nix)];
      }
    ];
  }; 
}
