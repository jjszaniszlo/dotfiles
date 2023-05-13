return {
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = false,
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip",
        },
      },
    },
    config = function()
      local lsp = require('lsp-zero').preset({})

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        mapping = {
          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm(),
          ['<C-y>'] = cmp.config.disable,
          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer',  keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
      })

      -- Auto pairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end,
    keys = {
      { "<space>e", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Diagnostic Open Float" },
      { "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Diagnostic Set Local List" },
    }
  },
}
