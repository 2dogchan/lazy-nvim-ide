return {
  -- custom language specific extension modules
  { import = "plugins.extras.lang" },

  -- disable nvim spectrum
  -- { "windwp/nvim-spectre", enabled = false },
  -- disable nvim-notify
  -- { "rcarriga/nvim-notify", enabled = false },
  -- { "folke/noice.nvim", enabled = false },
  -- { "folke/neoconf.nvim", enabled = false },

  -- vscode integration
  { import = "lazyvim.plugins.extras.vscode" },

  -- core language specific extension modules
  { import = "lazyvim.plugins.extras.formatting.prettier" },

  -- dap
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.dap.nlua" },
  { import = "lazyvim.plugins.extras.test.core" },

  -- project
  { import = "lazyvim.plugins.extras.util.project" },
}
