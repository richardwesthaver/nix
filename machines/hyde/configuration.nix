{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./containers.nix
    ];

  nix = {
    trustedUsers = [ "ellis" "root" "@wheel" ];
    autoOptimiseStore = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
    overlays = [];
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## firecracker prod recommendations
  boot.kernelParams = ["nosmt=force" "l1tf=full,force" "spec_store_bypass_disable=seccomp"];
  networking = {
    hostName = "hyde";
    wireless.enable = true;
    extraHosts = ''
      192.168.1.3 zor
      192.168.1.2 jekl
    '';
    useDHCP = false;
    interfaces.wlp3s0.useDHCP = true;
    interfaces.enp0s25.useDHCP = true;
    firewall.allowedTCPPorts = [
      80
      443
      8000
      6699
      3000
      6680
    ];
    firewall.allowedUDPPorts = [
      8000
      6699
      3535
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    wget emacs networkmanager git htop alacritty
  ];

  environment.variables.TERMINAL = "alacritty";
  services.openssh = {
    enable = true;
    permitRootLogin = "yes"; # TODO: configure as 'prohibit-password'
    extraConfig = "Compression no";
  };
  services.disnix.enable = true;
  services.redis.enable = true;
  services.ircdHybrid.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:swapcaps";
    libinput.enable = true;
    displayManager = {
      lightdm.enable = true;
      lightdm.greeters.mini.enable = true;
      lightdm.greeters.mini.user = "ellis";
      lightdm.greeters.mini.extraConfig = ''
        [greeter-hotkeys]
        	mod-key = control
          	shutdown-key = s
            	restart-key = r
              	hibernate-key = h
                	suspend-key = u
      '';
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
    };
  };

  users.users.ellis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  users.users.root = {
    openssh.authorizedKeys.keyFiles = [ /home/ellis/ssh-key.pub ];
  };
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.sudo.sshAgentAuth = true;
  security.pam.enableSSHAgentAuth = true;
  
  system.stateVersion = "20.03"; # Did you read the comment?
}
