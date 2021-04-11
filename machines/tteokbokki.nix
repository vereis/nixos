{ config, pkgs, ... }:

{
  imports = [
    ../profiles/base.nix

    ../modules/base.nix
    ../modules/docker.nix
    ../modules/zsh.nix
    ../modules/neovim.nix
    ../modules/keychain.nix
    ../modules/lorri.nix
  ];

  modules.base.enable = true;
  modules.zsh.enable = true;
  modules.docker.enable = true;
  modules.neovim.enable = true;
  modules.lorri.enable = true;
}
