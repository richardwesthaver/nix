{pkgs, lib, ...}:

{
  services = {
    disnix = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;

      displayManager = {
        lightdm.autoLogin = {
          enable = true;
          user = "root";
        };
        defaultSession = "none+icewm";
      };
      windowManager.icewm.enable = true;
    };
  };

  security.pam.services.lightdm-autologin.text = lib.mkForce ''
    auth     requisite pam_nologin.so
    auth     required  pam_succeed_if.so quiet
    auth     required  pam_permit.so
    account  include   lightdm
    password include   lightdm
    session  include   lightdm
  '';

  environment = {
    systemPackages = [
      pkgs.git
      pkgs.htop
      pkgs.tmux
    ];
  };
}
