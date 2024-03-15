local M = {}
if not M.capabilities then
	M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

require("neoconf").setup({})

function M.lsp_setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			require("core.utils").load_mappings("lspconfig_on_attach", { buffer = ev.buf })
		end,
	})
end

function M.setup_external_lsps()
	local function make_set(tbl)
		local set = {}
		for _, l in ipairs(tbl) do
			set[l] = true
		end
		return set
	end

	local lspconfigs = require("core.utils").get_lsp_configs(M.capabilities)
	local pkg_names = vim.tbl_map(function(name)
		return require("mason-lspconfig").get_mappings().mason_to_lspconfig[name]
	end, require("mason-registry").get_installed_package_names())

	local pkg_set = make_set(pkg_names)

	for name, config in pairs(lspconfigs) do
		if not pkg_set[name] then
			require("lspconfig")[name].setup(config)
		end
	end
end

M.opts = {
	mason = {
		ui = {
			icons = {
				package_pending = " ",
				package_installed = "󰄳 ",
				package_uninstalled = " 󰚌",
			},
		},
	},
	mason_lspconfig = {
		ensure_installed = { "lua_ls" },
		automatic_installation = false,
		handlers = require("core.utils").create_handlers_functions(M.capabilities),
	},
}

return M
