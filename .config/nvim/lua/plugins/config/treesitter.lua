local TreesitterOptions = {
	ensure_installed = { "c", "lua", "vimdoc", "vim" },
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = { enable = true },
}

return TreesitterOptions
