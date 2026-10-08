-- Structural (treesitter-aware) search & replace in the current buffer.
return {
  "cshuaimin/ssr.nvim",
  opts = {
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_confirm = "<cr>",
      replace_all = "<S-cr>",
    },
  },
  keys = {
    {
      "<localleader>sR",
      function()
        require("ssr").open()
      end,
      desc = "Structural Search & Replace",
    },
  },
}
