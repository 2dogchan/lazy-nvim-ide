local function notes_path(dir)
  return string.format("%s/%s", vim.fn.expand("$XDG_DATA_HOME") .. "/notes", dir)
end

return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.summary"] = {},
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = notes_path("norg"),
            },
            default_workspace = "notes",
            index = "index.norg",
          },
        },
      },
    },
  },

  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_key_mappings = {
        all_maps = 0,
        global = 0,
      }
      vim.g.vimwiki_list = {
        { path = notes_path("vimwiki"), ext = "md" },
      }
    end,
  },
}
