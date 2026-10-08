-- Tab bar. LazyVim provides <leader>bd / bo / bl / br / bp and [b ]b; we add vim-style first/last.
return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>b0", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "First Buffer" },
    { "<leader>b$", "<cmd>BufferLineGoToBuffer $<cr>", desc = "Last Buffer" },
  },
  opts = function(_, opts)
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      style_preset = require("bufferline").style_preset.minimal,
      separator_style = "thin",
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      indicator = { style = "underline" },
      modified_icon = "●",
      tab_size = 18,
      max_name_length = 24,
      truncate_names = true,
    })
    return opts
  end,
}
