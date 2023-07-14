return {
  -- check git history
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "history (file)" },
    { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "history (branch)" },
    { "<leader>gd", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "history (line)" },
  },
}
