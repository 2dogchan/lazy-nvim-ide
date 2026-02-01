return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
    {
      "<leader>fi",
      "<cmd>AerialNavToggle<cr>",
      desc = "Aerial Navigation",
    },
  },
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
}
