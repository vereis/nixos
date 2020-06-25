{ config, pkgs, ... }:

{
  imports =
    [
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    wget
    unzip
    unrar
    htop
    curl
    dmenu
    vim
    git
    firefox-bin
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  # NixOS uses X11 SSH Askpass by default; disable this and use CLI
  programs.ssh.askPassword = "";

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts
      fira-code
      font-awesome-ttf
      unifont
    ];

   # Think this is an updated `infinality` patch
   fontconfig.penultimate.enable = true; 
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Can't imagine why we wouldn't want OpenGL support
  hardware.opengl.enable = true;

  # Override nixos DWM with personal build
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs(_: {
        src = builtins.fetchGit {
	  url = "https://github.com/vereis/dwm";
          rev = "b06da0cf6a1bda66ca1f7671d3faa3b8062220c5";
          ref = "master";
        };
      });
    })
  ];

  # X Server settings
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    displayManager = {
      defaultSession = "none+dwm";
      lightdm.enable = true;
      lightdm.autoLogin.enable = true;
      lightdm.autoLogin.user = "chris";
    };

    windowManager.dwm.enable = true;

    exportConfiguration = true;
    config = ''
      Section "InputClass"
        Identifier "My Mouse"
        MatchIsPointer "on"

        Option "AccelerationNumerator" "1"
        Option "AccelerationDenominator" "1"
        Option "AccelerationThreshold" "0"

        Option "ConstantDeceleration" "7"
        Option "AdaptiveDeceleration" "7"
      EndSection
    '';

    enableCtrlAltBackspace = true;
  };

  # User config + home manager config
  users.users.chris = {
    isNormalUser = true;
    extraGroups = [ "sound" "wheel" ];
    shell = pkgs.zsh;
  };

  home-manager.users.chris = import ./home.nix { inherit pkgs config; };

  # Don't touch
  system.stateVersion = "20.03";
}

