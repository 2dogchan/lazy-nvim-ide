-- Zed-like statusline (lualine) and a winbar with file name + LSP breadcrumbs.
-- Breadcrumbs come from nvim-navic (LazyVim editor.navic extra); only the separator is changed here.
return {
  {
    "SmiteshP/nvim-navic",
    opts = {
      separator = " › ",
      depth_limit = 5,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          winbar = { "snacks_dashboard", "snacks_picker_list", "snacks_layout_box", "trouble", "aerial", "edgy" },
        },
      })

      -- Statusline: mode | branch | diagnostics + path ......... noice | git diff | encoding + ft | position
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:lower()
          end,
        },
      }
      opts.sections.lualine_b = { { "branch", icon = "" } }
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
      -- stylua: ignore
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
          symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
          source = function()
            local gs = vim.b.gitsigns_status_dict
            if gs then
              return { added = gs.added, modified = gs.changed, removed = gs.removed }
            end
          end,
        },
      }
      opts.sections.lualine_y = {
        { "encoding", padding = { left = 1, right = 0 } },
        { "filetype", padding = { left = 1, right = 1 } },
      }
      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }

      -- Winbar: icon + file name + breadcrumbs (active window only shows breadcrumbs)
      local file = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 0, symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" } },
      }
      opts.winbar = {
        lualine_c = vim.list_extend(vim.deepcopy(file), {
          { "navic", color_correction = "dynamic", padding = { left = 1, right = 0 } },
        }),
      }
      opts.inactive_winbar = { lualine_c = file }

      return opts
    end,
  },
}
