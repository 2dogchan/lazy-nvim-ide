return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>b0", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "First Buffer" },
    { "<leader>b$", "<Cmd>BufferLineGoToBuffer $<CR>", desc = "Last Buffer" },
    { "<leader>bc0", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close Left Buffer" },
    { "<leader>bc$", "<Cmd>BufferLineCloseRight<CR>", desc = "Close Right Buffer" },
  },
}
