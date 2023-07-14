local lspconfig_status_ok, gopls = pcall(require, "lspconfig.server_configurations.gopls")
if not lspconfig_status_ok then
  return
end

return {
  root_dir = function()
    return gopls.default_config.root_dir(vim.fn.getcwd())
  end,
}
