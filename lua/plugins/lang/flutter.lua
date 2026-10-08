-- Flutter / Dart: flutter-tools.nvim owns the dartls client (widget guides, closing labels, outline).
-- LazyVim's lang.dart extra adds the treesitter parser, dart_format and neotest-dart, but its lspconfig
-- dartls must stay off or two clients attach to every buffer.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = { enabled = false },
      },
    },
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Neovim 0.12 renders LSP document colors natively (flutter-tools' lsp.color is deprecated there).
      -- The style is global; dartls is currently the only server that provides colors.
      vim.lsp.document_color.enable(true, nil, { style = "■" })

      require("flutter-tools").setup({
        ui = { border = "rounded" },
        decorations = {
          statusline = { app_version = false, device = true },
        },
        widget_guides = { enabled = true },
        lsp = {
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
        debugger = { enabled = false, run_via_dap = false }, -- review-only setup
      })
    end,
  },
}
