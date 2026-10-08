-- Undo history browser with persistent undo across sessions.
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
  },
  init = function()
    local undodir = vim.fn.expand("~/.undo-nvim")
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p")
    end
    vim.opt.undodir = undodir
    vim.opt.undofile = true
    vim.g.undotree_WindowLayout = 2
  end,
}
