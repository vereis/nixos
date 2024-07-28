{ pkgs, lib, username, hyprland, swww, ... }:

{
  imports = [ ./hardware-configuration.nix ./services.nix ];

  environment.systemPackages = with pkgs; [ vulkan-loader vulkan-tools vulkan-validation-layers hyprland libnotify dunst swww.packages.${pkgs.system}.swww rofi-wayland ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "madoka";
  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 24800 51413 ];
  networking.firewall.allowedUDPPorts = [ 22 80 443 24800 51413 ];

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  xdg.portal.enable = true;

  hardware.nvidia.modesetting.enable = true;
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.gnome.gnome-keyring.enable = lib.mkForce false;
}
