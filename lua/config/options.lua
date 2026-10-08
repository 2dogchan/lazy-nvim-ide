-- Options are loaded before lazy.nvim starts. LazyVim's defaults:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Diagnostic display is configured in lua/plugins/coding/lsp.lua (LazyVim overrides it otherwise).

vim.g.maplocalleader = "\\"

-- Project root: LSP root first, cwd as fallback
vim.g.root_spec = { "lsp", "cwd" }

-- No remote-plugin providers are used
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Zed-like feel
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.showmode = false -- the statusline shows the mode
