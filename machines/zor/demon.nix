{pkgs, ...}:

{
  boot.loader.grub.device = "/dev/sda";
  services = {
    openssh.enable = true;
  };
}
