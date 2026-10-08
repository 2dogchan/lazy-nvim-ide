-- Right-hand scrollbar showing viewport, git hunks, diagnostics and search matches (GoLand style).
return {
  "dstein64/nvim-scrollview",
  event = "VeryLazy",
  opts = {
    excluded_filetypes = {
      "prompt",
      "noice",
      "notify",
      "snacks_dashboard",
      "snacks_notif",
      "snacks_picker_list",
      "snacks_layout_box",
    },
    current_only = true,
    winblend = 50,
    base = "right",
    column = 1,
    signs_on_startup = { "diagnostics", "search", "changelist" },
    diagnostics_error_symbol = "│",
    diagnostics_warn_symbol = "│",
    diagnostics_info_symbol = "│",
    diagnostics_hint_symbol = "│",
  },
  config = function(_, opts)
    require("scrollview").setup(opts)
    -- Mark git hunks on the scrollbar
    require("scrollview.contrib.gitsigns").setup({
      add_symbol = "│",
      change_symbol = "│",
      delete_symbol = "▁",
    })
  end,
}
