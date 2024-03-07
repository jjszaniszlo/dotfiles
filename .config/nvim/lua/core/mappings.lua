local Mappings = {}

local function loclist_wrap(dir)
    return function()
        if dir == "prev" then
            if not pcall(vim.cmd.lprev) then
                vim.cmd.llast()
            end
        elseif dir == "next" then
            if not pcall(vim.cmd.lnext) then
                vim.cmd.lfirst()
            end
        end
    end
end

local function close_buffer_or_split()
    local num_windows = #vim.api.nvim_tabpage_list_wins(0)
    if num_windows > 1 then
        vim.cmd.close()
    else
        vim.cmd.bd()
    end
end

Mappings.general = {
    ["<leader>q"] = { close_buffer_or_split, "Close current buffer or split" },

    ["<leader>n"] = { vim.cmd.noh, "Disable highlighting" },

    ["<c-h>"] = { "<c-w>h", "Move window left" },
    ["<c-j>"] = { "<c-w>j", "Move window down" },
    ["<c-k>"] = { "<c-w>k", "Move window up" },
    ["<c-l>"] = { "<c-w>l", "Move window right" },

    ["[b"] = { vim.cmd.bprev, "Goto next buffer" },
    ["]b"] = { vim.cmd.bnext, "Goto previous buffer" },

    ["n"] = { "nzzzv", "Goto previous search location" },
    ["N"] = { "Nzzzv", "Goto next search location" },

    ["<c-u>"] = { "<C-u>zz", "Move up half page (centered cursor)" },
    ["<c-d>"] = { "<C-d>zz", "Move down half page (centered cursor)" },

    ["Q"] = { "<nop>" },

    ["<leader>l"] = { vim.cmd.lopen, "Open location list" },
    ["<c-n>"] = { loclist_wrap("next"), "Select lext item in location list" },
    ["<c-p>"] = { loclist_wrap("prev"), "Select previous item in location list" },

    ["<leader>p"] = { "\"_dP", "Paste over without yanking", mode = "x" },
    ["<leader>d"] = { "\"_d", "Delete without yanking", mode = { "x", "n" } },

    ["<esc>"] = { "<c-\\><c-n>", "Terminal escape", mode = { "t" } },
}

local function nvim_tree_desc(str)
    return "[nvim-tree]: " .. str
end

Mappings.nvim_tree = {
    ["<leader>e"] = { require("nvim-tree.api").tree.open, nvim_tree_desc("Focus or open file tree") },
}

Mappings.nvim_tree_on_attach = {
    ["q"] = { require("nvim-tree.api").tree.close, nvim_tree_desc("Close file tree") },
}

local function lsp_desc(str)
    return "[lsp]: " .. str
end

Mappings.lspconfig = {}
Mappings.lspconfig_on_attach = {
    ["gD"] = { vim.lsp.buf.declaration, lsp_desc("Goto declaration") },
    ["gd"] = { vim.lsp.buf.definition, lsp_desc("Goto definition") },
    ["gi"] = { vim.lsp.buf.implementation, lsp_desc("Goto implementation") },
    ["K"] = { vim.lsp.buf.hover, lsp_desc("Hover") },
    ["<c-k>"] = { vim.lsp.buf.signature_help, lsp_desc("Open signature help window") },
    ["<leader>r"] = { vim.lsp.buf.rename, lsp_desc("Rename identifier") },
    ["<space>a"] = { vim.lsp.buf.code_action, lsp_desc("View code actions") },
    ["<leader>fm"] = { function() vim.lsp.buf.format { async = true } end, lsp_desc("Format file") },
}

Mappings.gitsigns_on_attach = {}

local function telescope_desc(str)
    return "[telescope]: " .. str
end

Mappings.telescope = {
    ["<leader>ff"] = { require("telescope.builtin").find_files, telescope_desc("Find files") },
    ["<leader>fg"] = { require("telescope.builtin").live_grep, telescope_desc("Live grep") },
    ["<leader>fb"] = { require("telescope.builtin").buffers, telescope_desc("Buffers") },
    ["<leader>fh"] = { require("telescope.builtin").help_tags, telescope_desc("Help tags") },
    ["<space>e"] = { function() require("telescope.builtin").diagnostics { bufnr = 0 } end, telescope_desc("Diagnostics") },
    ["gr"] = { require("telescope.builtin").lsp_references, telescope_desc("LSP references") },
}

return Mappings
