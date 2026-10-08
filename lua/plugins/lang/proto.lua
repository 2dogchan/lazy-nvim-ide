-- Protobuf: Buf's built-in language server (`buf lsp serve`, GA). Gives gd / gr / rename / hover,
-- buf-lint diagnostics and `buf format`. Uses the `buf` CLI already on PATH (mason = false).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        buf_ls = { mason = false },
      },
    },
  },
  {
    -- buf.yaml / buf.gen.yaml are served by buf_ls too (schema + diagnostics); keep YAML highlighting
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        filename = {
          ["buf.yaml"] = "buf-config",
          ["buf.gen.yaml"] = "buf-config",
          ["buf.policy.yaml"] = "buf-config",
          ["buf.lock"] = "buf-config",
        },
      })
      vim.treesitter.language.register("yaml", "buf-config")
    end,
  },
}
