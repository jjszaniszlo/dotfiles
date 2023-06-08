-- General Configuration
local opt            = vim.opt
opt.number           = true
opt.relativenumber   = true
opt.ruler            = true
opt.splitright       = true
opt.splitbelow       = true
opt.smarttab         = true
opt.expandtab        = true
opt.smartindent      = true
opt.autoindent       = true
opt.tabstop          = 2
opt.shiftwidth       = 2
opt.softtabstop      = 2
opt.autoread         = true
opt.title            = true
opt.termguicolors    = true
opt.hlsearch         = true
opt.hidden           = true
opt.encoding         = 'utf-8'
opt.fileencoding     = 'utf-8'
opt.showmode         = false
opt.clipboard        = 'unnamedplus'
opt.swapfile         = false
opt.laststatus       = 3
opt.scrolloff        = 7
opt.sidescrolloff    = 5
opt.wrap             = false

vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.o.foldenable     = true

-- Persistent Undo

opt.undofile         = true
opt.undodir          = os.getenv('HOME') .. '/.cache/nvim/undo'
opt.undolevels       = 1000
opt.undoreload       = 10000

vim.cmd('autocmd BufWinEnter * :set formatoptions-=c formatoptions-=r formatoptions-=o')

local defold_ft = vim.api.nvim_create_augroup("defold_ft", {})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = defold_ft,
  pattern = { "*.script", ".scriptc" },
  command = "set filetype=lua",
})


-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.c", "*.h"},
--   callback = function(ev)
--     print(string.format('event fired: s', vim.inspect(ev)))
--   end
-- })

-- neovide
if not vim.g.neovide then return end

vim.o.guifont = "BigBlueTermPlus Nerd Font Mono:h18"
vim.g.neovide_cursor_animation_length = 0

local function alpha()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

vim.g.neovide_transparency = 0.9
vim.g.neovide_background_color = "#0f1117" .. alpha()
vim.g.neovide_refresh_rate = 120
vim.g.neovide_refresh_rate_idle = 2
