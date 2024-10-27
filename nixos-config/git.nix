
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "dchristm77";
    userEmail = "derek.christman@gmail.com";
  };
}

