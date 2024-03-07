local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        require("core.utils").load_mappings("lspconfig_on_attach", { buffer = ev.buf })
    end,
})

local MasonOptions = {
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
        automatic_installation = true,
        handlers = require("core.utils").create_handlers_table(capabilities),
    },
}

return MasonOptions
