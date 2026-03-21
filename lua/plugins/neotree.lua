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
          local ok, err = pcall(Snacks.explorer.open, { cwd = vim.uv.cwd() })
          if not ok and not err:match("Invalid buffer") then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end,
        desc = "Explorer (project root)",
      },
      {
        "<leader>E",
        function()
          local ok, err = pcall(Snacks.explorer.open, { cwd = LazyVim.root() })
          if not ok and not err:match("Invalid buffer") then
            vim.notify(err, vim.log.levels.ERROR)
          end
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
