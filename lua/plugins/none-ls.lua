return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    vim.list_extend(opts.sources, {
      nls.builtins.formatting.dprint.with({
        condition = function(utils)
          return utils.root_has_file({ "dprint.json" }) or vim.loop.fs_stat("dprint.json")
        end,
      }),
      nls.builtins.formatting.prettier.with({ filetypes = { "markdown" } }),
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.deno_lint,
      nls.builtins.diagnostics.selene.with({
        condition = function(utils)
          return utils.root_has_file({ "selene.toml" })
        end,
      }),
      nls.builtins.formatting.isort,
      nls.builtins.formatting.black,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.luacheck.with({
        condition = function(utils)
          return utils.root_has_file({ ".luacheckrc" })
        end,
      }),
    })
  end,
}
