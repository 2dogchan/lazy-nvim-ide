local function dir(filepath)
  return vim.fn.isdirectory(filepath) ~= 0 and filepath or vim.fs.dirname(filepath)
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  keys = {
    {
      "<localleader>e",
      "<cmd>Neotree reveal_force_cwd<cr>",
      desc = "Explorer Neotree (reveal)",
    },
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    filesystem = {
      follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      commands = {
        copy_path_to_clipboard = function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            modify(filepath, ":."),
            filepath,
            modify(filepath, ":~"),
            filename,
            -- modify(filename, ":r"),
            -- modify(filename, ":e"),
          }

          vim.ui.select(results, {
            prompt = "Choose to copy to clipboard:",
          }, function(choice)
            vim.fn.setreg("+", choice)
          end)
        end,

        jump_to_parent_node = function(state)
          require("neo-tree.ui.renderer").focus_node(state, state.tree:get_node():get_parent_id())
        end,

        -- Find files in path
        find_files = function(state)
          require("telescope.builtin").find_files({ cwd = dir(state.tree:get_node():get_id()) })
        end,

        -- Search keyword in path
        live_grep = function(state)
          require("telescope.builtin").live_grep({ cwd = dir(state.tree:get_node():get_id()) })
        end,
      },
    },
    window = {
      mappings = {
        ["o"] = "open",
        ["Y"] = "copy_path_to_clipboard",
        ["u"] = "jump_to_parent_node",
        ["<leader><leader>"] = "find_files",
        ["<leader>/"] = "live_grep",
      },
    },
  },
}
