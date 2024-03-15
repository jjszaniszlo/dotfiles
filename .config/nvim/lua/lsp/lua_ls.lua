require("neodev").setup({
	override = function(root, lib)
		if root:find("~/dotfiles/", 1, true) == 1 then
			lib.enabled = true
			lib.plugins = true
		end
	end,
})

return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
