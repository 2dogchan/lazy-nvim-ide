-- Side panel layout (edgy.nvim, LazyVim ui.edgy extra). The extra already places Trouble, quickfix,
-- help, neotest, grug-far, aerial and snacks terminals; we add undotree and turn off animation.
return {
  "folke/edgy.nvim",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = function(_, opts)
    opts.wo = vim.tbl_deep_extend("force", opts.wo or {}, { spell = false })
    opts.animate = { enabled = false }
    opts.left = opts.left or {}
    table.insert(opts.left, { ft = "undotree", title = "UndoTree" })
  end,
}
