{ config, pkgs, ... }:
let
  cssColor = vals: pkgs.lib.foldlAttrs (acc: name: value: acc + "@define-color ${name} ${toString value};\n") "" vals;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      topBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "network"
          "battery"
          "clock"
          "tray"
          "custom/power"
        ];

        # Modules Configuration
        "hyprland/workspaces" = {
           "disable-scroll" = true;
           "all-outputs" = true;
           "warp-on-scroll" = false;
           "format" = "{name}: {icon}";
           "format-icons" = {
               "urgent" = "";
               "active" = "";
               "default" = "";
           };
        };

        "tray" = {
          "spacing" = 10;
        };
        
        "clock" = {
          "format" = "{:%a %I:%M %p %F}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };

        "battery" = {
          "states" = {
              "warning" = 30;
              "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-full" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% 󰂄";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["" "" "" "" ""];
        };
      
        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} 󰩠";
          "format-linked" = "{ifname} (No IP) 󰱓";
          "format-disconnected" = "Disconnected 󰅛";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };

        "custom/power" = {
          "format" = "⏻ ";
          "tooltip" = false;
          "menu" = "on-click";
          "menu-file" = "$HOME/.config/waybar/power_menu.xml";
          "menu-actions" = {
              "shutdown" = "shutdown";
              "reboot" = "reboot";
              "suspend" = "systemctl suspend";
              "hibernate" = "systemctl hibernate";
          };
        };

      };
    };
    
    style = ''
      @import "themes/mocha.css"; 

      * {
          font-family: "FiraCode Nerd Font Mono";
          font-size: 16px;
          min-height: 0;
          font-weight: bold;
      }

      window#waybar {
          background: transparent;
          background-color: @crust;
          color: @overlay0;
          transition-property: background-color;
          transition-duration: 0.1s;
          border-bottom: 1px solid @overlay1;
          border-radius: 15px;
      }

      #window {
          margin: 8px;
          padding-left: 8px;
          padding-right: 8px;
          border-radius: 15px;
      }

      button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 0;
      }

      button:hover {
          background: inherit;
          color: @mauve;
          border-top: 2px solid @mauve;
      }

      #workspaces button {
          padding: 0 4px;
      }

      #workspaces button.focused {
          background-color: rgba(0, 0, 0, 0.3);
          color: @rosewater;
          border-top: 2px solid @rosewater;
      }

      #workspaces button.active {
          background-color: rgba(0, 0, 0, 0.3);
          color: @mauve;
          border-top: 2px solid @mauve;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #pulseaudio,
      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #wireplumber,
      #tray,
      #network,
      #mode,
      #scratchpad {
        margin-top: 1px;
        margin-bottom: 1px;
        margin-left: 4px;
        margin-right: 4px;
        padding-left: 4px;
        padding-right: 4px;
      }

      #clock {
          color: @maroon;
      }

      #clock.date {
          color: @mauve;
      }

      #pulseaudio {
          color: @blue;
      }

      #network {
          color: @yellow;
      }

      #idle_inhibitor {
          margin-right: 12px;
          color: #7cb342;
      }

      #idle_inhibitor.activated {
          color: @red;
      }

      #battery {
          color: @green;
      }

      #custom-vpn {
          color: @lavender;
          border-radius: 15px;
          padding-left: 6px;
          padding-right: 6px;
      }
    '';
  };

  xdg.configFile = {
    "waybar/themes/mocha.css".text = cssColor {
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";

      text = "#cdd6f4";
      subtext0 = "#a6adc8";
      subtext1 = "#bac2de";

      surface0 = "#313244";
      surface1 = "#45475a";
      surface2 = "#585b70";

      overlay0 = "#6c7086";
      overlay1 = "#7f849c";
      overlay2 = "#9399b2";

      blue = "#89b4fa";
      lavender = "#b4befe";
      sapphire = "#74c7ec";
      sky = "#89dceb";
      teal = "#94e2d5";
      green = "#a6e3a1";
      yellow = "#f9e2af";
      peach = "#fab387";
      maroon = "#eba0ac";
      red = "#f38ba8";
      mauve = "#cba6f7";
      pink = "#f5c2e7";
      flamingo = "#f2cdcd";
      rosewater = "#f5e0dc";
    };

    "waybar/power_menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <interface>
        <object class="GtkMenu" id="menu">
          <child>
              <object class="GtkMenuItem" id="suspend">
                  <property name="label">Suspend</property>
              </object>
          </child>
          <child>
              <object class="GtkMenuItem" id="hibernate">
                  <property name="label">Hibernate</property>
              </object>
          </child>
          <child>
              <object class="GtkMenuItem" id="shutdown">
                  <property name="label">Shutdown</property>
              </object>
          </child>
          <child>
            <object class="GtkSeparatorMenuItem" id="delimiter1"/>
          </child>
          <child>
              <object class="GtkMenuItem" id="reboot">
                  <property name="label">Reboot</property>
              </object>
          </child>
        </object>
      </interface>
    '';
  };

}

