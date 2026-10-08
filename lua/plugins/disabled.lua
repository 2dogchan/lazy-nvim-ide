-- Every plugin we switch off, in one place. The replacement is noted next to each one.
return {
  -- Pickers / explorer: Snacks picker + Snacks explorer (see editor/picker.lua, editor/explorer.lua)
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  { "ibhagwan/fzf-lua", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "s1n7ax/nvim-window-picker", enabled = false },

  -- Colorschemes: OneDark only (see ui/colorscheme.lua)
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- Scrollbar: nvim-scrollview instead (see ui/scrollbar.lua)
  { "lewis6991/satellite.nvim", enabled = false },

  -- lang.markdown ships a browser preview that is unmaintained and needs Node; render-markdown.nvim stays
  { "iamcco/markdown-preview.nvim", enabled = false },
}
