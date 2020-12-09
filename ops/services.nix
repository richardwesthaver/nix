{system, pkgs, distribution, invDistribution}:

let
  customPkgs = import packages.nix {
    inherit pkgs system;
  };
  portsConfiguration = if builtins.pathExists ./ports.nix then import ./ports.nix else {};
in {
  hyde = rec {
    name = "hyde";
    pkg = customPkgs. { inherit name port; };
    dnsName = "hyde.local";
    type = "process";
    portAssign = "shared";
    port = portsConfiguration.ports.hyde or 0;
  };
}
