local M = {}

M.luasnip = {
	history = true,
	updateevents = "TextChanged,TextChangedI",
}

function M.init_luasnip()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

	require("luasnip.loaders.from_snipmate").load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

	require("luasnip.loaders.from_lua").load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if
				require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
				and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})
end

M.cmp = {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = require("cmp").config.window.bordered(),
		documentation = require("cmp").config.window.bordered(),
	},
	completion = {
		completeopt = "menu,menuone",
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	mapping = {
		["<c-p>"] = require("cmp").mapping.select_prev_item(),
		["<c-n>"] = require("cmp").mapping.select_next_item(),
		["<c-d>"] = require("cmp").mapping.scroll_docs(-4),
		["<c-f>"] = require("cmp").mapping.scroll_docs(4),
		["<c-Space>"] = require("cmp").mapping.complete(),
		["<c-e>"] = require("cmp").mapping.close(),
		["<c-y>"] = require("cmp").mapping.confirm({
			behavior = require("cmp").ConfirmBehavior.Insert,
			select = true,
		}),
	},
}

return M
