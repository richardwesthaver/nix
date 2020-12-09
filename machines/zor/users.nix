{ pkgs, ... }:

{
  users.extraUsers = {
    ellis = {
      isNormalUser = true;
      extraGroups = [ "sudo" "wheel" "disk" "dbus" "networkmanager" "wireshark" "vboxusers" "audio" "pulse" "libvirtd" "docker" "kvm" ];
      packages = with pkgs; [
        (import ./emacs.nix { inherit pkgs; })
      ];
    };
  };

  home-manager.users.ellis = import /home/ellis/src/home/ellis.nix;
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.sudo.sshAgentAuth = true;
  security.pam.enableSSHAgentAuth = true;
 }
