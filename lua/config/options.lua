-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- set local leader is '\'
vim.g.maplocalleader = "\\"

-- Enable spell check by default
-- vim.o.spell = true

-- Set conceal level to 0
-- vim.o.conceallevel = 0

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Always use the cwd where nvim was launched as root (don't auto-switch based on LSP)
vim.g.root_spec = { "cwd" }

-- Zed-like options
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.showmode = false

-- Zed-style diagnostic display
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})
