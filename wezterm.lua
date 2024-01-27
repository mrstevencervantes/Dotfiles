-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.audible_bell = 'Disabled'
-- config.color_scheme = 'Abernathy'
-- config.color_scheme = 'Argonaut (Gogh)'
config.color_scheme = 'Brogrammer'
-- config.color_scheme = 'Dark+'
-- config.color_scheme = 'Ef-Bio'
-- config.color_scheme = 'Ef-Dark'
-- config.color_scheme = 'Google Dark (Gogh)'
-- config.color_scheme = 'Helios (base16)'
-- config.color_scheme = 'Humanoid dark (base16)'
-- config.color_scheme = 'JetBrains Darcula'
-- config.color_scheme = 'midnight-in-mojave'
-- config.color_scheme = 'Nightlion V2 (Gogh)'
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.window_decorations = "RESIZE"
config.default_workspace = "Main"
config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
}
-- and finally, return the configuration to wezterm
return config
