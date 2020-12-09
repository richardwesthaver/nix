# Nix environment for SoundGarden
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in

  with nixpkgs;

  mkShell {
    buildInputs = [
      latest.rustChannels.stable.rust
      cargo
      rustc
      alsaLib
      cmake
      freetype
      expat
      openssl
      pkgconfig
      python3
      vulkan-validation-layers
      xlibs.libX11
    ];

    APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
      vulkan-loader
      xlibs.libXcursor
      xlibs.libXi
      xlibs.libXrandr
    ];

    shellHook = ''export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH'';
  }

