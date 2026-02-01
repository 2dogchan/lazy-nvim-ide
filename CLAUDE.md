# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim IDE configuration built on **LazyVim** (the opinionated starter framework), forked from `jellydn/lazy-nvim-ide`. It uses **lazy.nvim** as the plugin manager with ~103 plugins.

## Architecture

**Entry point**: `init.lua` → `require("config.lazy")` which bootstraps lazy.nvim and loads all config.

### Core Config (`lua/config/`)
- `lazy.lua` — Plugin manager bootstrap + LazyVim extras imports
- `keymaps.lua` — Custom keybindings (leader=space, localleader=backslash)
- `options.lua` — Vim options, disables Python3/Ruby/Perl/Node providers
- `autocmds.lua` — Auto-resize splits, disable auto-comment, close special buffers with `q`

### Plugin Specs (`lua/plugins/`)
Each file returns a lazy.nvim plugin spec table. Key files:
- `lsp.lua` — LSP server configs (tsserver, lua_ls, gopls, rust_analyzer, pyright, ruff, docker, yaml, etc.) + glance.nvim for previews
- `treesitter.lua` — 28 language parsers
- `telescope.lua` — Fuzzy finder with custom layout and keymaps
- `none-ls.lua` — Formatter/linter routing (prettier/biome/deno auto-detection, stylua, codespell, cspell, markdownlint, protolint)
- `colorscheme.lua` — TokyoNight theme with custom highlights
- `neotest.lua` — Test runner adapters (Jest, Vitest, Go, Rust, Python, Deno, Pest)
- `nvim_dap.lua` — Debug adapter protocol config
- `neotree.lua` — File explorer with custom commands
- `alpha.lua` — Dashboard
- `extras/copilot.lua` — Copilot + LuaSnip conflict resolution

### After Directory (`after/`)
- `ftplugin/` — Filetype-specific settings (lua, rust, go, proto, norg)
- `plugin/` — Additional keymaps and DAP config loaded after plugins
- `queries/` — TreeSitter query overrides (highlighting, injections, rainbow tags)

## Formatting

Lua files are formatted with **stylua** (2-space indent, 120 column width — see `stylua.toml`).

## Key Conventions

- Plugin specs follow LazyVim's pattern: return a table of specs from each file in `lua/plugins/`
- LazyVim extras are imported in `lua/config/lazy.lua` via the `import` key in the spec
- Spell checking dictionaries: `cspell.json` at repo root
- LSP project config: `.neoconf.json`
- Plugin versions locked in `lazy-lock.json`
