return {
  root_dir = require("lspconfig").util.root_pattern("package.json"),
  single_file_support = false,
  -- refer https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/274#discussioncomment-1515526
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false -- disable formatting in tsserver in favor of null-ls
  end,
  -- inlay hints
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayVariableTypeHints = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
