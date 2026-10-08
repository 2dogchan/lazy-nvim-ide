-- Folding via nvim-ufo (treesitter first, indent fallback). zR / zM open/close all, zk peeks a fold.
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99 -- ufo needs a high value; folds start open
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    -- Nerd Font chevrons for open/closed folds (written as escapes so they survive copy/paste)
    vim.o.fillchars = "eob: ,fold: ,foldopen:\u{f47c},foldsep: ,foldclose:\u{f460}"
  end,
  -- stylua: ignore
  keys = {
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
    { "zk", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek Fold" },
  },
}
