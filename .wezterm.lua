local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = 'Kanagawa (Gogh)'
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback {
    'Victor Mono',
    'Fira Code',
}

return config
