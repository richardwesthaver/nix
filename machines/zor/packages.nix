{ config, pkgs, ... }:
{
environment.systemPackages = with pkgs; [
  dmenu
  dunst
  libnotify # for notify-send
  rofi

  firefox
  google-chrome # unfree
  weechat

  pcmanfm
  epdfview
  geeqie
  scrot
  cmus
  alacritty

  aspell
  aspellDicts.en

  # ops
  nixops
  disnix
  disnixos
  
  # tools
  direnv
  fzf
  git
  wget
  tokei
  jq
  lsof
  htop
  
  # services
  darkhttpd
];
}
