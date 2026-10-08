-- Snacks picker (LazyVim default). LazyVim already binds <leader><space> files, <leader>fg git files,
-- <leader>sg grep, <leader>sR resume, <leader>ss symbols. We add one: files including hidden/ignored.
return {
  "snacks.nvim",
  keys = {
    {
      "<leader>fa",
      function()
        Snacks.picker.files({ hidden = true, ignored = true })
      end,
      desc = "Find All Files (hidden + ignored)",
    },
  },
}
