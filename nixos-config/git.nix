
{ config, pkgs, ... }:
{
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    userName = "dchristm77";
    userEmail = "derek.christman@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}

