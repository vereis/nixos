{ config, lib, pkgs, ... }:

with lib;
{
  options.modules.firefox = {
    enable = mkOption { type = types.bool; default = false; };
  };

  config = mkIf config.modules.firefox.enable {
    home.packages = with pkgs; [ firefox ];

    home.sessionVariables = {
      BROWSER = "firefox";
    };

    # TODO: Set everything up so that we can install userChrome.css and treeStyleTabs.css
    #       directly from Nix.
    #
    #       Until then, you need to configure/install the following:
    #
    #         1) Install `Tree Style Tabs`
    #         2) Enable `toolkit.legacyUserProfileCustomizations.stylesheets` in `about:config`
    #         3) Find your firefox profile path in `about:support`
    #         4) `ln -s $(pwd)/modules/home/firefox/chrome $HOME/.mozilla/firefox/$PROFILE/chrome`
    #         5) Copy the contents of `treeStyleTabs.css` to `about:addons/TreeStyleTabs`
    #
  };
}
