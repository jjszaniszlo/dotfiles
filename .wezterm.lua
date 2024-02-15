local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.color_scheme = 'Kanagawa (Gogh)'
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
config.font_size = 25
config.dpi = 144

-- tabs
local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
wezterm.on(
    "format-tab-title",
    function(tab, tabs, panes, config, hover, max_width)
        local title = tab_title(tab)
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Text = title },
        }
    end
)

return config
