-- Indent guides and smooth scrolling (snacks.indent / snacks.scroll), tuned to feel like Zed.
return {
  "snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      indent = { char = "│", hl = "SnacksIndent" },
      scope = { enabled = true, char = "│", hl = "SnacksIndentScope", underline = false },
      animate = {
        enabled = true,
        style = "out",
        duration = { step = 15, total = 300 },
      },
    },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 150 },
        easing = "linear",
      },
    },
  },
}
