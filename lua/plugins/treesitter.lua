return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "windwp/nvim-ts-autotag" },

    keys = {
      { "<S-cr>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },

    opts = {
      ensure_installed = {
        "bash",
        "regex",
        "vim",
        "lua",
        "html",
        "markdown",
        "markdown_inline",
        "css",
        "typescript",
        "tsx",
        "javascript",
        "http",
        "json",
        "json5",
        "jsonc",
        "graphql",
        "rust",
        "go",
        "toml",
        "c",
        "proto",
      },
      auto_install = true,
      -- ensure_installed = "all", -- one of "all" or a list of languages
      ignore_install = { "" }, -- List of parsers to ignore installing
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

      incremental_selection = {
        keymaps = {
          init_selection = "<S-cr>",
          node_incremental = "<S-cr>",
        },
      },

      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
      },
      autopairs = {
        enable = true,
      },
      indent = { enable = true, disable = { "python", "css" } },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      -- auto tag
      autotag = {
        enable = true,
      },
    },
  },
}
