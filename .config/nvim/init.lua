require("core")
require("jui")

-- bootstrap lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	require("core.bootstrap").load_lazy(lazypath)
end
vim.opt.rtp:prepend(lazypath)

require("plugins")

vim.cmd.colorscheme("kanagawa")

-- load global mappings
require("core.utils").load_mappings("general")
