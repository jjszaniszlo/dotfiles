vim.o.guifont = "BigBlueTermPlus Nerd Font Mono:h18"
vim.g.neovide_cursor_animation_length = 0

local function alpha()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

vim.g.neovide_transparency = 0.9
vim.g.neovide_background_color = "#0f1117" .. alpha()
vim.g.neovide_refresh_rate = 120
vim.g.neovide_refresh_rate_idle = 2
