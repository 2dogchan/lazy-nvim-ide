# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim IDE configuration built on **LazyVim**, forked from `jellydn/lazy-nvim-ide`. Uses **lazy.nvim** as the plugin manager. The aesthetic is intentionally **Zed editor-like** (OneDark theme, barbecue winbar, smooth scroll, minimal statusline).

## Formatting

Lua files are formatted with **stylua** (2-space indent, 120 column width — see `stylua.toml`).

## Architecture

**Entry point**: `init.lua` → `require("config.lazy")` → bootstraps lazy.nvim and loads everything.

### LazyVim Extras (two sources — both matter)

1. **`lua/config/lazy.lua`** — statically imports extras in the `spec` table (lang.go, lang.json, lang.yaml, dap.core, dap.nlua, test.core, ui.edgy, util.mini-hipatterns)
2. **`lazyvim.json`** — LazyVim's runtime state file, also lists enabled extras (dap.core, dap.nlua, editor.fzf, lang.go, lang.sql, test.core). LazyVim reads this at startup.

When adding/removing extras, update **both** files if the extra appears in both.

### Core Config (`lua/config/`)

| File | Purpose |
|------|---------|
| `lazy.lua` | Plugin manager bootstrap + LazyVim extras imports |
| `keymaps.lua` | Custom keybindings (leader=space, localleader=`\`) |
| `options.lua` | Vim options, disables Python3/Ruby/Perl/Node providers, Zed-style diagnostics |
| `autocmds.lua` | Auto-resize splits, disable auto-comment, close special buffers with `q`, big-file handling (>512KB disables syntax/LSP/folding) |

### Plugin Specs (`lua/plugins/`)

Each file returns a lazy.nvim plugin spec table. Key files:

- `lsp.lua` — LSP servers (bashls, gopls, yamlls, lua_ls, vimls) + glance.nvim, dim.lua, lsp-lens.nvim
- `treesitter.lua` — Language parsers with >1MB file guard
- `telescope.lua` — **Telescope is disabled**; replaced by **fzf-lua** (configured in this file)
- `colorscheme.lua` — OneDark theme with custom highlights; TokyoNight/catppuccin disabled
- `zed-ui.lua` — Barbecue winbar, nvim-navic breadcrumbs, Snacks indent/scroll, lualine statusline
- `neotest.lua` — Test runner (neotest-golang adapter)
- `nvim_dap.lua` — DAP config with `${workspaceFolder}` substitution
- `neotree.lua` — File explorer with path-scoped fzf-lua integration (`<leader><leader>`, `<leader>/`)
- `alpha.lua` — Dashboard (Zed logo)
- `bufferline.lua` — Tab bar with vim-style buffer nav (`<leader>b0`, `<leader>b$`)
- `edgy.lua` — Window/panel layout management
- `close-buffer.lua` — Auto-closes inactive buffers after 30 min
- `aerial.lua` — Code structure outline
- `folding.lua` — UFO folding (treesitter > indent)
- `flash.lua` — Motion plugin (regular search interception disabled)
- `diffview.lua` — Git diff viewer
- `vscode.lua` — Minimal config when running inside VSCode Neovim extension

### After Directory (`after/`)

- `ftplugin/` — Filetype indent settings (lua: 2-space, go: 4-tab, proto: 4-tab)
- `plugin/keymaps.lua` — Swaps `$`/`g_`, remaps `<C-u>`→10k, `<C-d>`→10j, `<C-e>`/`<C-y>` 3x scroll
- `queries/` — TreeSitter query overrides for Go injections

## Key Conventions

- Plugin specs follow LazyVim's pattern: return a table of specs from each file in `lua/plugins/`
- Spell checking dictionaries: `cspell.json` at repo root
- LSP project config: `.neoconf.json`
- Plugin versions locked in `lazy-lock.json`
- fzf-lua is the primary search/picker tool (not Telescope)
