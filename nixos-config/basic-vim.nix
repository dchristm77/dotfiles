
{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      history = 1000;
      ignorecase = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      smartcase = true;
    };
    extraConfig = ''
      set nocompatible
      set nobackup
      set scrolloff=10
      set showcmd
      set showmode
      set showmatch
    '';
  };
}
