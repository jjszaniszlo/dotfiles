local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "clangd", "gdscript", "csharp_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.zls.setup {
    cmd = { "/Users/jjszaniszlo/Source Code/zls-0.12.0/zig-out/bin/zls" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        zls = {
          semantic_tokens = "full",
          warn_style = true,
          highlight_global_var_declarations = true,
          enable_snippets = true,
          enable_autofix = true,
          enable_inlay_hints = false,
          inlay_hints_show_builtin = true,
          inlay_hints_exclude_single_argument = true,
          inlay_hints_hide_redundant_param_names = true,
          inlay_hints_hide_redundant_param_names_last_token = true,
          skip_std_references = true,
          record_session = true,
        },
    },
}
--[[
lspconfig.omnisharp.setup {
    handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
    cmd = { "dotnet", "/Users/jjszaniszlo/Source Code/omnisharp/OmniSharp.dll" },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = true,
}
]]--

-- disable auto format
vim.g.zig_fmt_autosave = 0
