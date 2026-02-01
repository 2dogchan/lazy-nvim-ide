return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- Force reinstall all parsers after plugin update to keep query/parser in sync
      local install = require("nvim-treesitter.install")
      local langs = require("nvim-treesitter.config").get_installed()
      for _, lang in ipairs(langs) do
        install.install(lang, { force = true })
      end
    end,
    keys = {
      { "<S-cr>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "bash",
        "regex",
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "luap",
        "go",
        "gomod",
        "gosum",
        "gowork",
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

      incremental_selection = {
        keymaps = {
          init_selection = "<S-cr>",
          node_incremental = "<S-cr>",
        },
      },

      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 1024 * 1024 -- 1 MB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      autopairs = {
        enable = true,
      },
      indent = { enable = true },
    },
  },
}
