{ config, pkgs, ... }:

{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_12;
      dataDir = "/data/pg";
      port = 6600;
    };
    blueman = {
      enable = true;
    };
    openssh.enable = true;
    emacs.enable = true;
    rsyncd.enable = true;
  };
  
#  security.acme = {
#    acceptTerms = true;
#    certs = {
#      "rwest.io".email = "richard.westhaver@gmail.com";
#    };
#  };
}
