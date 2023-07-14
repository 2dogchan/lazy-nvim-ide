local function notes_path(dir)
  return string.format("%s/%s", vim.fn.expand("$XDG_DATA_HOME") .. "/notes", dir)
end

return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-neorg/neorg-telescope",
        config = function()
          local neorg_callbacks = require("neorg.callbacks")

          neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
            -- Map all the below keybinds only when the "norg" mode is active
            keybinds.map_event_to_mode("norg", {
              n = { -- Bind keys in normal mode
                { "<C-s>", "core.integrations.telescope.find_linkable" },
              },

              i = { -- Bind in insert mode
                { "<C-l>", "core.integrations.telescope.insert_link" },
              },
            }, {
              silent = true,
              noremap = true,
            })
          end)
        end,
      },
    },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.integrations.telescope"] = {},
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
