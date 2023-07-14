return {
  "mg979/vim-visual-multi",
  lazy = false,
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_highlight_matches = "underline"
    vim.g.VM_theme = "codedark"
    vim.g.VM_maps = {
      ["Find Word"] = "<M-e>",
      ["Find Under"] = "<M-e>",
      ["Find Subword Under"] = "<M-e>",
      ["Select Cursor Down"] = "<M-]>",
      ["Select Cursor Up"] = "<M-[>",
    }
  end,
}
