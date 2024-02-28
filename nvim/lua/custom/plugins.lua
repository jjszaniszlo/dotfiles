local plugins = {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
        dependencies = {
            "Hoffs/omnisharp-extended-lsp.nvim",
        },
    },
    {
        "nanotee/zoxide.vim",
    },
}

return plugins
