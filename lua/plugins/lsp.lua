return {
  {
    "dnlhc/glance.nvim",
    keys = {
      { "gld", "<cmd>Glance definitions<cr>", desc = "Glance Definition" },
      { "glr", "<cmd>Glance references<cr>", desc = "Glance References" },
      { "glt", "<cmd>Glance type_definitions<cr>", desc = "Glance Type Definition" },
      { "gli", "<cmd>Glance implementations<cr>", desc = "Glance Implementation" },
    },
  },
  {
    -- Dim the unused variables and functions using lsp and treesitter.
    "narutoxy/dim.lua",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = true,
  },
  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        bashls = {},
        gopls = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local gomodcache = vim.fn.system("go env GOMODCACHE"):gsub("%s+$", "")
            if vim.v.shell_error == 0 and gomodcache ~= "" and fname:sub(1, #gomodcache) == gomodcache then
              local clients = vim.lsp.get_clients({ name = "gopls" })
              if #clients > 0 then
                on_dir(clients[#clients].config.root_dir)
                return
              end
            end
            on_dir(vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git"))
          end,
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
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
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
    },
  },
  {
    -- Displaying references and definition infos upon functions (like GoLand)
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    opts = {
      include_declaration = false,
      sections = {
        definition = false,
        references = true,
        implementation = false,
      },
    },
    keys = {
      {
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Lens Toggle",
      },
    },
  },
}
