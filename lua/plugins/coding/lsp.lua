-- Language-agnostic LSP setup. Per-language servers live in lang/.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Type / parameter annotations help when reading code you did not write.
      -- Dart is excluded because flutter-tools already draws closing labels.
      -- NOTE: this list replaces LazyVim's default (lazy.nvim does not concatenate arrays), so "vue" is kept.
      inlay_hints = { enabled = true, exclude = { "vue", "dart" } },
      -- Code lenses from gopls (run test / tidy) and rust-analyzer (run / references). <leader>cc runs one.
      codelens = { enabled = true },
      -- Zed-style diagnostics: small dot, compact spacing, rounded float
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = { prefix = "●", spacing = 2, source = "if_many" },
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      },
      servers = {
        bashls = {},
        vimls = {},
        yamlls = {
          settings = { yaml = { keyOrdering = false } },
        },
      },
    },
  },

  -- Tools installed through mason (language extras add their own)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "stylua", "selene", "luacheck", "shellcheck", "shfmt" })
      -- No debugger in this setup: drop the adapters language extras ask for, and dedupe
      local seen, kept = {}, {}
      for _, pkg in ipairs(opts.ensure_installed) do
        if pkg ~= "codelldb" and pkg ~= "delve" and not seen[pkg] then
          seen[pkg] = true
          kept[#kept + 1] = pkg
        end
      end
      opts.ensure_installed = kept
    end,
  },
}
