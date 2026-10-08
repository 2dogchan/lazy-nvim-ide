-- Treesitter parsers (language extras add their own). Highlighting is skipped for files over 1 MB.
return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    -- Reinstall every parser after a plugin update so queries and parsers stay in sync
    local install = require("nvim-treesitter.install")
    for _, lang in ipairs(require("nvim-treesitter.config").get_installed()) do
      install.install(lang, { force = true })
    end
  end,
  opts = {
    ensure_installed = {
      "bash",
      "regex",
      "vim",
      "vimdoc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "proto",
    },
    auto_install = true,
    sync_install = false,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > 1024 * 1024
      end,
    },
    indent = { enable = true },
  },
}
