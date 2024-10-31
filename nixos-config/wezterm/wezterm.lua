local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.use_dead_keys = false
config.check_for_updates = false
config.initial_cols = 100
config.initial_rows = 55
config.scrollback_lines = 5000
config.window_decorations = RESIZE


return config
