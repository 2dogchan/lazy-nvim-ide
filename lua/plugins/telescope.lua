local function live_grep_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")

    return vim.v.shell_error == 0
  end

  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end

  local opts = {}

  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end

  require("telescope.builtin").live_grep(opts)
end

local function fallback_to_find_files_if_not_git()
  local opts = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

return {
  {
    "telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = { "truncate" },
      },
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fg",
        function()
          fallback_to_find_files_if_not_git()
        end,
        desc = "Find Git File",
      },
      -- find in file 
      -- stylua: ignore
      {
        "<leader>fw",
        function()
          live_grep_from_project_git_root()
        end,
        desc = "Live Grep in Project Root",
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            -- 预览界面滚动
            ["<c-j>"] = require("telescope.actions").preview_scrolling_down,
            ["<c-k>"] = require("telescope.actions").preview_scrolling_up,
            ["<c-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<c-l>"] = require("telescope.actions").preview_scrolling_right,
            -- 翻页
            ["<C-f>"] = require("telescope.actions").results_scrolling_down,
            ["<C-b>"] = require("telescope.actions").results_scrolling_up,
            -- 分割窗口
            ["<C-s>"] = require("telescope.actions").file_split,
            ["<C-v>"] = require("telescope.actions").file_vsplit,
          },
        },
      },
    },
    -- add telescope-fzf-native
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        config = function()
          require("telescope").load_extension("undo")
          vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
        end,
      },
    },
  },
}
