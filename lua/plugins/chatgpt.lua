return {
  {
    "jackMort/ChatGPT.nvim",
    url = "https://github.com/2dogchan/ChatGPT.nvim.git",
    keys = {
      { "<localleader>c", "<cmd>ChatGPT<cr>", desc = "Open CahtGPT" },
    },
    event = "VeryLazy",
    config = true,
  },

  -- -- add status line icon for copilot
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     local Util = require("lazyvim.util")
  --     table.insert(opts.sections.lualine_x, 2, {
  --       function()
  --         local icon = require("lazyvim.config").icons.kinds.Copilot
  --         return icon
  --       end,
  --       cond = function()
  --         local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
  --         return ok and #clients > 0
  --       end,
  --       color = function()
  --         return Util.fg("Special")
  --       end,
  --     })
  --   end,
  -- },
}
