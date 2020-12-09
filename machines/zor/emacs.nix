{ pkgs ? import <nixpkgs> {} }:

let
  demacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesGen demacs).emacsWithPackages;
in
emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
  soothe-theme
  ample-theme
  perspective
  pdf-tools
  toml-mode
  yaml-mode
  web-mode
  which-key
  winum
  yasnippet
  smartparens
  super-save
  ob-rust
  org-download
  org-make-toc
  org-bullets
  rustic
  nix-mode
  edit-server
  lsp-mode
  caddyfile-mode
  magit
  js2-mode
  rjsx-mode
]))

