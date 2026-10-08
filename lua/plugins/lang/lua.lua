-- Lua (this config itself): lua_ls settings and a lazydev path fix.
return {
  {
    -- lazydev hardcodes lua_root=true, which makes `gd` on require("config.lazy") look for
    -- config/lazy.lua instead of lua/config/lazy.lua. lua_root=false resolves lua/?.lua correctly.
    "folke/lazydev.nvim",
    init = function()
      require("lazydev.config").lua_root = false
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { workspaceWord = true, callSnippet = "Both" },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = { privateName = { "^_" } },
              type = { castNumberToInteger = true },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = { strong = "Warning", strict = "Warning" },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false, -- stylua formats Lua
                defaultConfig = { indent_style = "space", indent_size = "2", continuation_indent_size = "2" },
              },
            },
          },
        },
      },
    },
  },
}
