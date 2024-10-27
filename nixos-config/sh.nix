{ config, pkgs, ... }:
let

  myAliases = {
    ll = "ls -al";
  };

in
{
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
