{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
    };

    mosh.enable = true;

    tmux = {
      enable = true;
      clock24 = true;
      aggressiveResize = true;
      keyMode = "emacs";
      baseIndex = 1;
      newSession = true;
      escapeTime = 0;
      extraConfig = ''
        set-option -g mouse on
      '';
    };

    screen.screenrc = ''
      multiuser on
      acladd normal_user
    '';
    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor =  "emacs";
    };      
    wireshark.enable = true;
    bandwhich.enable = true;
    
  };

  environment.variables.TERMINAL = ["alacritty"];
}
