{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./programs.nix
      ./services.nix
      ./users.nix
      ./packages.nix
      ./containers.nix
      <home-manager/nixos>
    ];

  nix = {
    trustedUsers = [ "ellis"];
    autoOptimiseStore = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
    overlays = [
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "zor";
    wireless.enable = false;
    extraHosts = "
       192.168.1.4 hyde
       192.168.1.2 jekl
    ";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      80
      443
      8000
      6699
      6600
      3000
      6680
    ];
    firewall.allowedUDPPorts = [
      8000
      6699
      3535
    ];
  };
  
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  #  networking.interfaces.wlp3s0.useDHCP = true; # note: wireless is disabled by default

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "America/New_York";


  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };
    pulseaudio = {
      enable = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
    };
  };

  # Enable sound.
  sound.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    autorun = true;
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
      extraPackages = with pkgs; [dmenu i3status-rust i3lock];
    };

    # libinput.enable = true;
#    videoDrivers = [ "nouveau" "intel" ];
  };

  system.stateVersion = "20.09";

}

