-- Rust: LazyVim lang.rust extra (rustaceanvim + crates.nvim), tuned for reviewing:
-- clippy instead of plain `cargo check`, and no codelldb/DAP wiring.
return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      -- Replaces the extra's on_attach, which binds <leader>dr debuggables and shadows LazyVim's
      -- <leader>cR (Rename File) with a Rust code-action menu. Plain <leader>ca already covers code actions.
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>cE", function()
          vim.cmd.RustLsp("expandMacro")
        end, { desc = "Rust Expand Macro", buffer = bufnr })
      end,
      default_settings = {
        ["rust-analyzer"] = {
          check = { command = "clippy" },
        },
      },
    },
  },
  -- Override the extra's config so the codelldb adapter is never set up
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable("rust-analyzer") == 0 then
      LazyVim.error(
        "**rust-analyzer** not found in PATH. Install it with `rustup component add rust-analyzer`.",
        { title = "rustaceanvim" }
      )
    end
  end,
}
