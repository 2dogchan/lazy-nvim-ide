-- OneDark "warmer" everywhere, with a Darcula-style palette for Dart only (fewer colors, easier to skim).
return {
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

      -- Dart: Darcula-like, intentionally low-contrast between token kinds
      local fg, kw, fn, str, num, cmt = "#A9B7C6", "#CC7832", "#FFC66D", "#6A8759", "#6897BB", "#808080"
      local keyword = { fg = kw, bold = true }
      local dart_hls = {
        ["@variable.dart"] = { fg = fg },
        ["@variable.member.dart"] = { fg = fg },
        ["@variable.parameter.dart"] = { fg = fg },
        ["@variable.builtin.dart"] = { fg = fg },
        ["@property.dart"] = { fg = fg },
        ["@field.dart"] = { fg = fg },
        ["@parameter.dart"] = { fg = fg },
        ["@constant.dart"] = { fg = fg },
        ["@constant.builtin.dart"] = keyword,
        ["@function.dart"] = { fg = fn },
        ["@function.call.dart"] = { fg = fn },
        ["@function.method.dart"] = { fg = fn },
        ["@function.method.call.dart"] = { fg = fn },
        ["@method.dart"] = { fg = fn },
        ["@method.call.dart"] = { fg = fn },
        ["@constructor.dart"] = { fg = fn },
        ["@keyword.dart"] = keyword,
        ["@keyword.return.dart"] = keyword,
        ["@keyword.function.dart"] = keyword,
        ["@keyword.operator.dart"] = keyword,
        ["@keyword.conditional.dart"] = keyword,
        ["@keyword.repeat.dart"] = keyword,
        ["@keyword.exception.dart"] = keyword,
        ["@keyword.import.dart"] = { fg = kw },
        ["@keyword.type.dart"] = keyword,
        ["@type.dart"] = { fg = fg },
        ["@type.builtin.dart"] = keyword,
        ["@type.qualifier.dart"] = keyword,
        ["@string.dart"] = { fg = str },
        ["@string.escape.dart"] = { fg = kw },
        ["@number.dart"] = { fg = num },
        ["@number.float.dart"] = { fg = num },
        ["@boolean.dart"] = keyword,
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

  { "LazyVim/LazyVim", opts = { colorscheme = "onedark" } },
}
