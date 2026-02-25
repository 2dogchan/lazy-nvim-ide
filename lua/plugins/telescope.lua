return {
  -- Disable telescope and fzf-lua (replaced by snacks picker)
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  { "ibhagwan/fzf-lua", enabled = false },

  -- Custom Snacks picker keymaps
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git File",
      },
      {
        "<leader>fw",
        function()
          Snacks.picker.grep({ cwd = LazyVim.root() })
        end,
        desc = "Live Grep in Project Root",
      },
      {
        "gR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume Last Picker",
      },
      {
        "<leader>fa",
        function()
          Snacks.picker.files({ hidden = true, ignored = true })
        end,
        desc = "Find All Files (including hidden)",
      },
    },
  },
}
