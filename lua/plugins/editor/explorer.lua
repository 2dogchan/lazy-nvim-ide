-- File tree (snacks.explorer). <leader>e opens at the shell cwd, <leader>E at the LazyVim root.
-- The pcall swallows a known "Invalid buffer" race when toggling quickly.
local function open(cwd)
  return function()
    local ok, err = pcall(Snacks.explorer.open, { cwd = cwd() })
    if not ok and not tostring(err):match("Invalid buffer") then
      vim.notify(tostring(err), vim.log.levels.ERROR)
    end
  end
end

return {
  "snacks.nvim",
  opts = {
    explorer = { replace_netrw = true },
    picker = {
      sources = {
        explorer = { hidden = true, ignored = true, follow_file = true },
      },
    },
  },
  keys = {
    { "<leader>e", open(vim.uv.cwd), desc = "Explorer (cwd)" },
    { "<leader>E", open(LazyVim.root), desc = "Explorer (root)" },
  },
}
