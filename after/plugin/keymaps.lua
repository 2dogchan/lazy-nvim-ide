local opts = { silent = true }

-- 交换'$'和'g_'
vim.keymap.set({ "n", "v" }, "$", "g_")
vim.keymap.set({ "n", "v" }, "g_", "$")

-- 让ctrl+d,ctrl+u平滑滚动
vim.keymap.set("n", "<C-u>", "10k", opts)
vim.keymap.set("n", "<C-d>", "10j", opts)

vim.keymap.set("n", "<C-e>", "3<C-e>", opts)
vim.keymap.set("n", "<C-y>", "3<C-y>", opts)

-- tabs
-- vim.keymap.set("n", "<leader><tab>e", "<cmd>tabedit %<cr>", { desc = "Edit with new Tab" })
