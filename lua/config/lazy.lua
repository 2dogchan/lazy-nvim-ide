-- Bootstrap lazy.nvim, then load LazyVim + the extras and plugin folders below.
--
-- Layout of lua/plugins/ (each folder is imported explicitly, lazy.nvim does not recurse):
--   disabled.lua  every plugin we turn off, in one place
--   ui/           how it looks: colorscheme, statusline, dashboard, bufferline, scrollbar, layout, folding
--   editor/       moving around: picker, explorer, flash, undotree, structural replace, buffer retirement
--   review/       the ADE core: git signs, inline blame, diffview
--   coding/       language-agnostic: LSP defaults, treesitter, test runner
--   lang/         per-language: go, rust, flutter, lua
--   vscode.lua    minimal setup when running inside VSCode

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Languages (Go / Rust / Flutter) + data formats
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.dart" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- Tests: kept to verify AI-written changes. No debugger on purpose.
    { import = "lazyvim.plugins.extras.test.core" },

    -- Reading code: breadcrumbs, sticky function header, symbol outline, side panels
    { import = "lazyvim.plugins.extras.editor.navic" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.ui.edgy" }, -- must come before editor.aerial
    { import = "lazyvim.plugins.extras.editor.aerial" },

    -- Claude Code IDE integration (<leader>a…)
    { import = "lazyvim.plugins.extras.ai.claudecode" },

    -- Color swatches for hex codes etc.
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- Our own specs
    { import = "plugins" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.review" },
    { import = "plugins.coding" },
    { import = "plugins.lang" },
  },
  defaults = {
    lazy = false, -- our own specs load at startup unless they say otherwise
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true }, -- notify when plugin updates are available
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
