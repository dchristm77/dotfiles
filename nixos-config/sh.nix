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
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
