{pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 8080 ];
  services.disnix.enable = true;
  services.openssh.enable = true;
  dysnomia.properties = {
    capacity = 10;
  };

  users.extraGroups = {
    nginx = { gid = 60; };
  };

  users.extraUsers = {
    nginx = { group = "nginx"; uid = 60; };
  };
}
