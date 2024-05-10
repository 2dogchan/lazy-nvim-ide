return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>b0", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "First Buffer" },
      { "<leader>b$", "<Cmd>BufferLineGoToBuffer $<CR>", desc = "Last Buffer" },
      { "<leader>bc", desc = "+close" },
      { "<leader>bc0", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close Left Buffer" },
      { "<leader>bc$", "<Cmd>BufferLineCloseRight<CR>", desc = "Close Right Buffer" },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      window = {
        width = 0.85, -- width will be 85% of the editor width
      },
    },
    config = true,
    keys = {
      -- add <leader>cz to enter zen mode
      {
        "<leader>cz",
        "<cmd>ZenMode<cr>",
        desc = "Zen Mode",
      },
    },
  },
  {
    "folke/flash.nvim",
    -- Dont intercept the `Regular Search`
    opts = { modes = { search = { enabled = false } } },
  },
}
