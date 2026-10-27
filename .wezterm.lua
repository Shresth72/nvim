local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.default_prog = { "wsl.exe", "~" }
config.term = "xterm-kitty"

-- Remove window padding
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Streamlined keys for tmux users
config.keys = {
  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom "Clipboard",
  },
}

return config
