-- disable lsp-inlayhints if that is nightly version, will remove when 0.10.0 is stable
local enabled_inlay_hints = true
if vim.fn.has("nvim-0.10.0") == 1 then
  enabled_inlay_hints = false
end

return {
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte", "go" },
    enabled = enabled_inlay_hints,
    opts = {
      debug_mode = true,
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
      require("lsp-inlayhints").setup(options)
      -- define key map for toggle inlay hints: require('lsp-inlayhints').toggle()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>uh",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle Inlay Hints" }
      )
    end,
  },
  {
    "rmagatti/goto-preview",
    opts = {
      default_mappings = true,
      -- default_mappings = false, and then you can map preview window with your favorite keymap
      -- nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
      -- nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
      -- nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
      -- nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
      -- nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
    },
    ft = { "go", "lua" },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opts = {},
    config = true,
    enabled = false, -- disable lspsaga, use goto-preview instead
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      -- Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      -- LSP finder - Find the symbol's definition
      { "glf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
      -- Go to definition
      { "gld", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
      -- Go to type definition
      { "glt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to Type Definition" },
      -- Toggle Outline
      { "glo", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
      -- Peek definition
      { "glp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      -- Hover Doc
      { "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
    },
  },

  {
    -- Displaying references and definition infos upon functions like JB's IDEA.
    "VidocqH/lsp-lens.nvim",
    event = "BufRead",
    opts = {
      include_declaration = true, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implementation = false,
      },
    },
    keys = {
      {
        -- LspLensToggle
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Len Toggle",
      },
    },
  },
  {
    -- Dim the unused variables and functions using lsp and treesitter.
    "narutoxy/dim.lua",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            "codespell",
            "misspell",
          })
        end,
      },
    },
    opts = function(_, opts)
      for _, file in
        ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugins/extras/lsp", [[v:val =~ '\.lua$']]))
      do
        local server = file:gsub("%.lua$", "")
        local src_opts = require("plugins.extras.lsp." .. server)
        opts.servers[server] = vim.tbl_deep_extend("force", opts.servers[server] or {}, src_opts)
      end
    end,
  },
}
