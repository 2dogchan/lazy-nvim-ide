return {
  -- Disable unused colorschemes
  { "nickkadutskyi/jb.nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },
  { "projekt0n/github-nvim-theme", enabled = false },
  { "maxmx03/solarized.nvim", enabled = false },
  { "sainnhe/everforest", enabled = false },

  -- OneDark warmer（Go 保持原味，Dart 单独用 Darcula 风格覆盖）
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "warmer",
      transparent = false,
      term_colors = true,

      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      diagnostics = {
        darker = true,
        undercurl = true,
        background = false,
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()

      -- 只对 Dart 文件应用 Darcula 风格：减少颜色种类
      local fg = "#A9B7C6"
      local kw = "#CC7832"
      local fn = "#FFC66D"
      local str = "#6A8759"
      local num = "#6897BB"
      local cmt = "#808080"

      local dart_hls = {
        ["@variable.dart"] = { fg = fg },
        ["@variable.member.dart"] = { fg = fg },
        ["@variable.parameter.dart"] = { fg = fg },
        ["@variable.builtin.dart"] = { fg = fg },
        ["@property.dart"] = { fg = fg },
        ["@field.dart"] = { fg = fg },
        ["@parameter.dart"] = { fg = fg },
        ["@constant.dart"] = { fg = fg },
        ["@constant.builtin.dart"] = { fg = kw, bold = true },
        ["@function.dart"] = { fg = fn },
        ["@function.call.dart"] = { fg = fn },
        ["@function.method.dart"] = { fg = fn },
        ["@function.method.call.dart"] = { fg = fn },
        ["@method.dart"] = { fg = fn },
        ["@method.call.dart"] = { fg = fn },
        ["@constructor.dart"] = { fg = fn },
        ["@keyword.dart"] = { fg = kw, bold = true },
        ["@keyword.return.dart"] = { fg = kw, bold = true },
        ["@keyword.function.dart"] = { fg = kw, bold = true },
        ["@keyword.operator.dart"] = { fg = kw, bold = true },
        ["@keyword.conditional.dart"] = { fg = kw, bold = true },
        ["@keyword.repeat.dart"] = { fg = kw, bold = true },
        ["@keyword.exception.dart"] = { fg = kw, bold = true },
        ["@keyword.import.dart"] = { fg = kw },
        ["@keyword.type.dart"] = { fg = kw, bold = true },
        ["@type.dart"] = { fg = fg },
        ["@type.builtin.dart"] = { fg = kw, bold = true },
        ["@type.qualifier.dart"] = { fg = kw, bold = true },
        ["@string.dart"] = { fg = str },
        ["@string.escape.dart"] = { fg = kw },
        ["@number.dart"] = { fg = num },
        ["@number.float.dart"] = { fg = num },
        ["@boolean.dart"] = { fg = kw, bold = true },
        ["@comment.dart"] = { fg = cmt, italic = true },
        ["@operator.dart"] = { fg = fg },
        ["@punctuation.dart"] = { fg = fg },
        ["@punctuation.bracket.dart"] = { fg = fg },
        ["@punctuation.delimiter.dart"] = { fg = fg },
        ["@module.dart"] = { fg = fg },
        ["@namespace.dart"] = { fg = fg },
        ["@attribute.dart"] = { fg = "#BBB529" },
      }

      for group, hl in pairs(dart_hls) do
        vim.api.nvim_set_hl(0, group, hl)
      end
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
