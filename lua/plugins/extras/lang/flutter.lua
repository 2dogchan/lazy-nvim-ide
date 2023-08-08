return {
  "akinsho/flutter-tools.nvim",
  ft = { "dart" },
  cmd = { "FlutterRun" },
  keys = {
    { "<localleader>fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
    { "<localleader>fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
    { "<localleader>fo", "<cmd>FlutterOutline<cr>", desc = "Flutter Outline" },
    { "<localleader>fs", "<cmd>FlutterRun<cr>", desc = "Flutter Start" },
    { "<localleader>fS", "<cmd>FlutterRun<cr>", desc = "Flutter Restart" },
    { "<localleader>fr", "<cmd>FlutterReload<cr>", desc = "Flutter HotReload" },
    { "<localleader>fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
    { "RobertBrunhage/flutter-riverpod-snippets", lazy = false }, -- useful flutter snippets
  },
  config = function()
    require("flutter-tools").setup()

    -- Auto commands
    vim.api.nvim_create_autocmd("BufWrite", { pattern = "*.dart", command = "FlutterReload" })
  end,
}
