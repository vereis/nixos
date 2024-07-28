{ pkgs, ... }:

{
  imports = [
    ../../../modules/home/hyprland.nix
    ../../../modules/home/firefox.nix
    ../../../modules/home/git.nix
    ../../../modules/home/kitty.nix
    ../../../modules/home/tmux.nix
    ../../../modules/home/ncmpcpp.nix
    ../../../modules/home/neovim.nix
    ../../../modules/home/vetspire.nix
    ../../../modules/home/ranger.nix
    ../../../modules/home/zsh.nix
  ];

  modules.hyprland.enable = true;
  modules.firefox.enable = true;
  modules.git.enable = true;
  modules.kitty.enable = true;
  modules.kitty.fontSize = 14;
  modules.tmux.enable = true;
  modules.ncmpcpp.enable = true;
  modules.neovim.enable = true;
  modules.ranger.enable = true;
  modules.zsh.enable = true;
  modules.vetspire.enable = true;
}
