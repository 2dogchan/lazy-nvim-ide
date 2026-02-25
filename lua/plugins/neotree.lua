return {
  -- Disable neo-tree, use snacks.explorer instead
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "s1n7ax/nvim-window-picker", enabled = false },

  -- Configure snacks.explorer to match previous neo-tree behavior
  {
    "snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer.open({ cwd = vim.uv.cwd() })
        end,
        desc = "Explorer (project root)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer.open({ cwd = LazyVim.root() })
        end,
        desc = "Explorer (LazyVim root)",
      },
    },
  },

  -- snacks.picker explorer tree: show dotfiles and gitignored files
  {
    "snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            follow_file = true,
          },
        },
      },
    },
  },
}
