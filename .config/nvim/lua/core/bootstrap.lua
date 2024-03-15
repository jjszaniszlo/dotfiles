local Bootstrap = {}
local Utilities = require("core.utils")

function Bootstrap.load_lazy(lazypath)
	Utilities.vim_echo("Installing Lazy!")

	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	vim.opt.rtp:prepend(lazypath)

	-- initialize lazy and plugins
	require("plugins")
end

return Bootstrap
