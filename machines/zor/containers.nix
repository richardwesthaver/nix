{ pkgs, ...}:

{
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 56250; to   = 56260; } ];
    allowedTCPPorts = [ 21 ];
                        };
  networking.firewall.connectionTrackingModules = [ "ftp" ];
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  containers = {
    ftp = {
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      config =
        { config, pkgs, ... }:
        { services.vsftpd = {
            enable = true;
            localUsers = true;
            userlistEnable = true;
            userlist = [ "ellis" ];
            extraConfig = "pasv_min_port=56250\npasv_max_port=56260";
          };
      };
    };
    postgres = {
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.12";
      config =
        { config, pkgs, ... }:
        { services.postgresql = {
          enable = true;
          package = pkgs.postgresql_10;
          enableTCPIP = true;
          settings = {
            listen-addreses = "*";
          };
          authentication = pkgs.lib.mkForce ''
            local all all trust
            host all all ::1/128 trust
            host all all 0.0.0.0/0 md5
          '';
          initialScript = pkgs.writeText "backend-initScript" ''
            CREATE ROLE db_user WITH LOGIN PASSWORD 'hackme' CREATEDB;
            CREATE DATABASE local;
            GRANT ALL PRIVILEGES ON DATABASE local TO db_user;
          '';
          };
        };
    };
  };
}
