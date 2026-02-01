return {
  { "nickkadutskyi/jb.nvim", lazy = false, priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jb",
    },
  },
  -- Disable unused colorschemes from LazyVim defaults
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },
}
