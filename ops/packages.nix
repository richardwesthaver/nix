{pkgs, system}:

let
  callPackage = pkgs.lib.callPackageWith (pkgs // self);
  self = {
    hyde = (import ./services/hyde {
      inherit system pkgs;
    }).package;
#    demonwrapper = callPackage ./services/demon/wrapper.nix { };
  };
in
self
    
