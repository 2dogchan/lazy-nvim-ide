if vim.g.vscode then
  return
end

require("dap.ext.vscode").load_launchjs()
