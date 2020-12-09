{ pkgs, ...}:

{
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";
  containers.database =
    {
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      config =
      { config, pkgs, ... }:
      { services.postgresql.enable = true;
      services.postgresql.package = pkgs.postgresql_9_6;
      };
  };
}
