vim.keymap.set("n", "<leader>n", "<cmd>noh<cr>", { desc = "No Highlight" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "NetRW Explore" })

-- visual move up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Visual Move Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Visual Move Up" })

-- move line below to after current line
vim.keymap.set("n", "J", "mzJ`z")

-- move up and down but keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor centered when jumping between search finds.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")

-- replace without changing paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Replace with p-buffer" })

-- error nagivation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<cr>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<cr>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<cr>zz")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make File Executable" })

vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close buffer" })

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
