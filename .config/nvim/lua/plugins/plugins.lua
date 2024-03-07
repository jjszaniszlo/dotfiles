local Plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = require "plugins.config.treesitter",
        config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                init = function()
                    require("telescope").load_extension('fzf')
                end,
            },
        },
        opts = require("plugins.config.telescope"),
        init = function()
            require("core.utils").load_mappings("telescope")
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
        end
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        event = { "User" },
        opts = require "plugins.config.lsp",
        init = function()
            require("core.utils").load_mappings("lspconfig")
        end,
        config = function(_, opts)
            require("mason").setup(opts.mason)
            require("mason-lspconfig").setup(opts.mason_lspconfig)
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("core.utils").load_mappings("nvim_tree")
        end,
        opts = require "plugins.config.nvim-tree"
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opts = function() return require("plugins.config.completion").cmp end,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                config = function()
                    require("luasnip").config.set_config(require("plugins.config.completion").luasnip)
                    require("plugins.config.completion").init_luasnip()
                end,
            },
            {
                "windwp/nvim-autopairs",
            },
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
    },
    {
        "rebelot/kanagawa.nvim",
        opts = require "plugins.config.kanagawa",
    },
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "]", "[", "<space>", "g", },
        cmd = "WhichKey",
        opts = {},
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 150
        end
    },
}

return Plugins
