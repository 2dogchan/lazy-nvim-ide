--- Live grep from project git root
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
    opts = { cwd = get_git_root() }
  end

  require("fzf-lua").live_grep(opts)
end

--- Fallback to git_files if in git repo
local function fallback_to_find_files_if_not_git()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("fzf-lua").git_files()
  else
    require("fzf-lua").files()
  end
end

return {
  -- Disable telescope
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>fg",
        function()
          fallback_to_find_files_if_not_git()
        end,
        desc = "Find Git File",
      },
      {
        "<leader>fw",
        function()
          live_grep_from_project_git_root()
        end,
        desc = "Live Grep in Project Root",
      },
      {
        "gR",
        function()
          require("fzf-lua").resume()
        end,
        desc = "Resume Last FzfLua",
      },
      {
        "<leader>fa",
        function()
          require("fzf-lua").files({ cmd = "fd --type f --hidden --no-ignore --follow" })
        end,
        desc = "Find All Files (including hidden)",
      },
    },
  },
}
