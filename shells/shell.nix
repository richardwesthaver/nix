let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  gst = import ./gst.nix { inherit pkgs; };
  
  mergeEnvs = envs: pkgs.mkShell (builtins.foldl' (a: v: {
    buildInputs = a.buildInputs ++ v.buildInputs;
    nativeBuildInputs = a.nativeBuildInputs ++ v.nativeBuildInputs;
    propagatedBuildInputs = a.propagatedBuildInputs ++ v.propagatedBuildInputs;
    propagatedNativeBuildInputs = a.propagatedNativeBuildInputs ++ v.propagatedNativeBuildInputs;
    shellHook = a.shellHook + "\n" + v.shellHook;
  }) (pkgs.mkShell {}) envs);

in mergeEnvs [ gst ]
