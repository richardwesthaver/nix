# gstreamer shell
# gst-inspect-1.0 autoaudiosink
{ pkgs ? import <nixpkgs> {} }:

with pkgs;
mkShell {
  buildInputs = [
    gst_all_1.gstreamer.dev
    gst-plugins-good
  ];
  shellHooks = ''
    export LANG="en_US";
    export GST_PLUGIN_SYSTEM_PATH="${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0/:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0/"
    export PATH="$PATH:${gst_all_1.gstreamer.dev}/bin"
  '';  
}
