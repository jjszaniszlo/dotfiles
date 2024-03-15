local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.ruler = true

opt.splitright = true
opt.splitbelow = true

opt.smarttab = true
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.autoread = true
opt.title = true
opt.termguicolors = true
opt.hlsearch = true
opt.hidden = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.laststatus = 3
opt.scrolloff = 7
opt.sidescrolloff = 5
opt.wrap = false

opt.cursorline = true

opt.shell = "fish"

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Persistent Undo
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undo"
opt.undolevels = 1000
opt.undoreload = 10000

vim.opt.updatetime = 100
