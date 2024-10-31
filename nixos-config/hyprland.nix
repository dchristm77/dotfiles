
{ inputs, config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    
    settings = {
      "$terminal" = "wezterm";
      "$mod" = "SUPER";

      monitor = [ ",prefered,auto,1" ];
      
      bind = [
        "$mod, t, exec, $terminal"
        "$mod SHIFT, e, exit" 
      ];
      
    };
  };
}