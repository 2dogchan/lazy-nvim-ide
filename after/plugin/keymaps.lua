-- 交换'$'和'g_'
vim.keymap.set({ "n", "v" }, "$", "g_")
vim.keymap.set({ "n", "v" }, "g_", "$")

-- 让ctrl+d,ctrl+u平滑滚动
vim.keymap.set("n", "<C-d>", "10j")
vim.keymap.set("n", "<C-u>", "10k")

vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "<C-y>", "3<C-y>")

-- tabs
-- vim.keymap.set("n", "<leader><tab>e", "<cmd>tabedit %<cr>", { desc = "Edit with new Tab" })
