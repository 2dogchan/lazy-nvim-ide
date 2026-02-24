return {
  -- Winbar breadcrumbs (file path + code context, like Zed)
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "BufReadPost",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-mini/mini.icons",
    },
    opts = {
      create_autocmd = false,
      attach_navic = true,
      show_dirname = false,
      show_basename = true,
      show_modified = true,
      lead_custom_section = function()
        return " "
      end,
      theme = "auto",
      symbols = {
        separator = ">",
      },
      kinds = false,
    },
    config = function(_, opts)
      require("barbecue").setup(opts)
      vim.api.nvim_create_autocmd({
        "WinScrolled",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },

  -- LSP-powered code context for breadcrumbs
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.supports_method("textDocument/documentSymbol") then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,
    opts = {
      separator = " > ",
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
      lsp = {
        auto_attach = false,
      },
    },
  },

  -- Snacks indent/scroll tuning for Zed feel
  {
    "snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        indent = {
          char = "│",
          hl = "SnacksIndent",
        },
        scope = {
          enabled = true,
          char = "│",
          hl = "SnacksIndentScope",
          underline = false,
        },
        animate = {
          enabled = true,
          style = "out",
          duration = {
            step = 15,
            total = 300,
          },
        },
      },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 150 },
          easing = "linear",
        },
      },
    },
  },

  -- Zed-like statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      })

      local icons = LazyVim.config.icons

      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:lower()
          end,
        },
      }

      opts.sections.lualine_b = {
        { "branch", icon = "" },
      }

      opts.sections.lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      }

      -- stylua: ignore start
      opts.sections.lualine_x = {
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return { fg = Snacks.util.color("Statement") } end,
        },
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      }
      -- stylua: ignore end

      opts.sections.lualine_y = {
        { "encoding", padding = { left = 1, right = 0 } },
        { "filetype", padding = { left = 1, right = 1 } },
      }

      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }

      return opts
    end,
  },
}
