local Plugins = {
	{ "folke/neodev.nvim", opts = {} },
	{ "milisims/nvim-luaref", lazy = false },
	{
		"stevearc/conform.nvim",
		keys = { "<leader>fm" },
		opts = require("plugins.config.misc").conform,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = require("plugins.config.treesitter"),
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				init = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		opts = require("plugins.config.telescope"),
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},
	{ "nvim-lint" },
	{ -- dap
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				{
					"rcarriga/nvim-dap-ui",
					opts = require("plugins.config.dap").dap_ui,
                    dependencies = {
                        "nvim-neotest/nvim-nio"
                    },
				},
			},
			keys = { "<leader>d", "<leader>b", "<F5>", "<F10>", "<F11>", "<F12>" },
			init = function()
				require("core.utils").load_mappings("dap")
			end,
			config = function()
				require("plugins.config.dap").init()
			end,
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"folke/neoconf.nvim",
		},
		event = { "User" },
		opts = function()
			return require("plugins.config.lsp").opts
		end,
		init = function()
			require("core.utils").load_mappings("lspconfig")
		end,
		config = function(_, opts)
			require("mason").setup(opts.mason)
			require("mason-lspconfig").setup(opts.mason_lspconfig)
			require("plugins.config.lsp").lsp_setup()
			require("plugins.config.lsp").setup_external_lsps()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			require("core.utils").load_mappings("nvim_tree")
		end,
		opts = require("plugins.config.nvim-tree"),
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opts = function()
			return require("plugins.config.completion").cmp
		end,
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
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		keys = { "<leader>" },
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.config.harpoon")
		end,
	},
	{ -- misc
		{
			"rebelot/kanagawa.nvim",
			opts = require("plugins.config.misc").kanagawa,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = require("plugins.config.misc").autopairs,
			config = function(_, opts)
				require("nvim-autopairs").setup(opts)
				require("plugins.config.misc").autopairs_init()
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			event = { "BufReadPost", "BufNewFile" },
			opts = require("plugins.config.misc").gitsigns,
		},
		{
			"christoomey/vim-tmux-navigator",
			opts = require("plugins.config.misc").vim_tmux_navigator,
		},
		{
			"numToStr/Comment.nvim",
			keys = { "gc", "gb", "gcc", "gbc", "g" },
			dependencies = {
				"JoosepAlviste/nvim-ts-context-commentstring",
				opts = { enable_autocmd = false },
				config = function(_, opts)
					require("ts_context_commentstring").setup(opts)
				end,
			},
			opts = require("plugins.config.misc").comment,
			config = function(_, opts)
				opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
				require("Comment").setup(opts)
			end,
		},
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "]", "[", "<space>", "g" },
		cmd = "WhichKey",
		opts = {},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 150
		end,
	},
}

return Plugins
