return {
  -- Disable unused colorschemes
  { "nickkadutskyi/jb.nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- One Dark theme (Zed-style)
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      lualine = {
        transparent = false,
      },

      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },

      highlights = {
        -- Subtle indent guides
        SnacksIndent = { fg = "#3b3f4c" },
        SnacksIndentScope = { fg = "#565c6e" },

        -- Clean cursorline
        CursorLine = { bg = "#2c313a" },
        CursorLineNr = { fg = "#e5c07b", bold = true },

        -- Clean floating windows
        NormalFloat = { bg = "#21252b" },
        FloatBorder = { fg = "#3e4452", bg = "#21252b" },

        -- Winbar / breadcrumbs
        WinBar = { fg = "#7f848e", bg = "NONE" },
        WinBarNC = { fg = "#5c6370", bg = "NONE" },

        -- Muted line numbers
        LineNr = { fg = "#4b5263" },

        -- Clean fold column
        FoldColumn = { fg = "#4b5263", bg = "NONE" },
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },

  -- Tell LazyVim to use onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
