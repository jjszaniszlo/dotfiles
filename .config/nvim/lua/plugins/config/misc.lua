local M = {}

function M.autopairs_init()
	require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
end

M.autopairs = {
	fast_wrap = {},
	disable_filetype = { "TelescopePrompt", "vim" },
}

M.comments = {
	ignore = "^$",
}

M.conform = {
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang_format" },
		zig = { "zigfmt" },
	},
    formatters = {
    }
}

-- return empty tables for misc plugins that do not have a config in here
return setmetatable(M, {
	__index = function()
		return {}
	end,
})
