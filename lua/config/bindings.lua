local function mapn(lhs, rhs, opts)
  opts.silent = opts.silent ~= nil and opts.silent or true
  vim.keymap.set("n", lhs, rhs, opts)
end

mapn("<leader><Space>", "<cmd>noh<cr>", { desc = "No Highlight" })
