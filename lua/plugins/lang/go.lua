-- Go: LazyVim lang.go extra (gopls, gofumpt, goimports, golangci-lint, neotest-golang) plus one fix:
-- when jumping into a file inside GOMODCACHE, reuse the project's gopls instead of starting a new one.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local gomodcache = vim.fn.system("go env GOMODCACHE"):gsub("%s+$", "")
          if vim.v.shell_error == 0 and gomodcache ~= "" and fname:sub(1, #gomodcache) == gomodcache then
            local clients = vim.lsp.get_clients({ name = "gopls" })
            if #clients > 0 then
              on_dir(clients[#clients].config.root_dir)
              return
            end
          end
          on_dir(vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git"))
        end,
      },
    },
  },
}
