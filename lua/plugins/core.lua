return {
  {
    -- kanagawa
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup {
        overrides = function(colors)
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              },
            },
          },
        },
      }
      vim.cmd.colorscheme("kanagawa")
      vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
    end,
  },

  {
    -- tree-sitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "lua", "tsx", "typescript", "vimdoc", "vim", "zig", "javascript",
          "html", "css" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
        autotag = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
      }
    end
  },
  {
    -- which-key
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end,
  },

  {
    -- lualine
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "kanagawa",
        component_separators = "|",
      },
    },
  },

  {
    -- telescope
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {}
    end,
    keys = {
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Telescope find files" },
      {
        -- from prime
        "<leader>ps",
        function()
          require("telescope.builtin").grep_string { search = vim.fn.input("grep > ") }
        end,
        desc = "Telescope Grep String",
      }
    },
  },

  {
    -- fzf native for telescope
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },

  {
    -- autopairs
    "windwp/nvim-autopairs",
    dependencies = "nvim-treesitter",
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
      require("nvim-autopairs").add_rules(require "nvim-autopairs.rules.endwise-lua")
    end,
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
        client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = false,                      -- Displays the current line number instead of the current project
        blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time           = true,                       -- Show the timer
        editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Tmux navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Tmux navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Tmux navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux navigate right" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>",        desc = "Harpoon Add File" },
      { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon Quick Menu" },
      { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>",          desc = "Harpoon Navigate Next" },
      { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>",          desc = "Harpoon Navigate Next" },
      { "<leader>1",  "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",         desc = "Harpoon Navigate File 1" },
      { "<leader>2",  "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",         desc = "Harpoon Navigate File 2" },
    },
    config = function()
      require("harpoon").setup {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
        mark_branch = false,
      }

      require("telescope").load_extension("harpoon")
    end
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require 'nvim_comment'.setup {
        comment_empty = false,
        marker_padding = true,
        create_mappings = true,
        line_mapping = 'gcc',
        operating_mapping = 'gc',
        hook = nil,
      }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
    end,
    keys = {
      { "zR", "<cmd>lua require('ufo').openAllFolds<cr>",  desc = { "UFO Open All Folds" } },
      { "zM", "<cmd>lua require('ufo').closeAllFolds<cr>", desc = { "UFO Open All Folds" } },
    }
  }
}
