local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = 'Kanagawa (Gogh)'
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

return config
