return {
  -- 让 gutter 的 git 修改标记更醒目（类似 VSCode/GoLand 的彩色竖条）
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      numhl = true,
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379" })
          vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#98c379" })
          vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#98c379" })
          vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "GitSignsUntrackedNr", { fg = "#98c379" })
        end,
      })
    end,
  },

  -- 禁用 satellite（换 scrollview）
  { "lewis6991/satellite.nvim", enabled = false },

  -- 右侧滚动条：显示当前视口 + git 修改 + 诊断 + 搜索（GoLand 风格）
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts = {
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "alpha",
        "neo-tree",
        "snacks_dashboard",
        "snacks_notif",
      },
      current_only = true,
      winblend = 50,
      base = "right",
      column = 1,
      signs_on_startup = {
        "diagnostics",
        "search",
        "changelist",
      },
      diagnostics_error_symbol = "│",
      diagnostics_warn_symbol = "│",
      diagnostics_info_symbol = "│",
      diagnostics_hint_symbol = "│",
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
      -- gitsigns 集成：在滚动条上标记 git 修改位置
      require("scrollview.contrib.gitsigns").setup({
        add_symbol = "│",
        change_symbol = "│",
        delete_symbol = "▁",
      })
    end,
  },
}
