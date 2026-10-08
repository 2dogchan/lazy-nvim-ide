# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Neovim configuration built on **LazyVim** (lazy.nvim plugin manager). Aesthetic is intentionally **Zed editor-like**: OneDark theme, breadcrumbs in the winbar, smooth scroll, minimal statusline.

**Purpose: an "ADE"**, an AI-era editor for *reviewing* code written by AI agents (Rust, Go, Flutter/Dart). Not for hand-debugging: there is intentionally **no DAP/debugger** stack. When a LazyVim extra and a third-party plugin both do the job, **prefer the LazyVim extra**.

Requires Neovim >= 0.12 (uses `vim.lsp.document_color`, `client:request`).

## Formatting

Lua is formatted with **stylua** (2-space indent, 120 columns, see `stylua.toml`). The binary is installed by mason at `~/.local/share/nvim/mason/bin/stylua`.

## Layout

```
init.lua                      → require("config.lazy")
lua/config/
  lazy.lua                    bootstrap + LazyVim extras + imports of every plugins/ folder
  options.lua                 vim options (leader, root_spec, providers off, Zed feel)
  keymaps.lua                 ALL custom keymaps, grouped by purpose (see cheat sheet below)
  autocmds.lua                auto-resize, no auto-comment, big-file guard (>512KB), cmdline nosmartcase
lua/plugins/
  disabled.lua                every plugin turned off, with its replacement noted
  vscode.lua                  minimal setup when running inside the VSCode Neovim extension
  ui/                         colorscheme, statusline (+winbar), dashboard, bufferline, scrollbar,
                              indent-scroll, layout (edgy), folding (ufo)
  editor/                     picker, explorer, flash, undotree, ssr, buffers (early retirement)
  review/                     git.lua: gitsigns (signs, inline blame) + diffview
  coding/                     lsp.lua (inlay hints, codelens, diagnostics, mason tools), treesitter, neotest
  lang/                       go, rust, flutter, lua, proto (buf_ls)
after/
  ftplugin/                   indent per filetype (lua/dart 2 spaces, go/proto 4 tabs)
  queries/go/                 treesitter injection overrides
```

lazy.nvim does **not** recurse into subfolders: each `plugins/<dir>` is imported explicitly in `lazy.lua`. Adding a folder means adding an import line.

### LazyVim extras (two sources, keep in sync)

`lua/config/lazy.lua` imports the extras statically; `lazyvim.json` records the same set (plus `editor.snacks_explorer` / `editor.snacks_picker`, which are only in the json). Enabled: lang.go, lang.rust, lang.toml, lang.dart, lang.json, lang.yaml, lang.markdown, test.core, editor.navic, editor.aerial, ui.treesitter-context, ui.edgy, ai.claudecode, util.mini-hipatterns. `ui.edgy` must be imported before `editor.aerial`.

### Things that are easy to get wrong

- **Flutter**: `flutter-tools.nvim` (org `nvim-flutter/`) owns the dartls client. `lang/flutter.lua` disables lspconfig's `dartls` from the dart extra; re-enabling it attaches two clients.
- **Rust**: `lang/rust.lua` replaces the rust extra's `config` so codelldb is never wired. `rust-analyzer` must exist in every rustup toolchain a project pins (`rustup component add rust-analyzer --toolchain <name>`).
- **Mason**: `coding/lsp.lua` filters `codelldb` and `delve` out of `ensure_installed`. lazy.nvim replaces (does not concatenate) array opts such as `inlay_hints.exclude`.
- **Diagnostics display** is set via `nvim-lspconfig` `opts.diagnostics` in `coding/lsp.lua`, not `vim.diagnostic.config()` in options.lua (LazyVim would overwrite it).
- **Pickers**: Snacks picker + Snacks explorer. Telescope, fzf-lua and neo-tree are disabled in `disabled.lua`.

## Keymap cheat sheet (custom only)

LazyVim defaults apply everywhere else (`gd` `gr` `gI` `gy` `K`, `<leader>c…` code, `<leader>g…` git, `<leader>s…` search, `<leader>x…` diagnostics, `<leader>t…` tests, `<leader>u…` toggles). Note `gr` is `nowait`, so Neovim's built-in `grr`/`grn`/`gra` never fire.

| Key | Action | Defined in |
|---|---|---|
| `<leader>a…` | Claude Code: `ac` toggle, `as` send selection, `ab` add buffer, `aa`/`ad` accept/deny diff | ai.claudecode extra |
| `<leader>gv` | Toggle Diffview of the working tree | review/git.lua |
| `<leader>gH` | File history (visual: line-range history) | review/git.lua |
| `<leader>uB` | Toggle inline line blame (`<leader>uG` is LazyVim's git signs toggle) | keymaps.lua |
| `<leader>ux` | Toggle errors-only diagnostics | keymaps.lua |
| `<leader>uq` | Toggle `q` macro recording (off by default) | keymaps.lua |
| `<leader>uu` | Undo tree | editor/undotree.lua |
| `<leader>ut` / `<leader>um` | Toggle treesitter context / markdown rendering | extras |
| `<leader>cs` | Symbol outline (aerial) | editor.aerial extra |
| `<leader>cc` | Run codelens under cursor | LazyVim |
| `<leader>cE` | Rust: expand macro under cursor (rust buffers) | lang/rust.lua |
| `<leader>e` / `<leader>E` | Explorer at cwd / at LazyVim root | editor/explorer.lua |
| `<leader>fa` | Find files incl. hidden and ignored | editor/picker.lua |
| `<leader>xf` | Pick FIXME comments | keymaps.lua |
| `<leader>b0` / `<leader>b$` | First / last buffer | ui/bufferline.lua |
| `<leader>;` | Close everything, show dashboard | keymaps.lua |
| `<S-q>` | Close buffer (dashboard when none left) | keymaps.lua |
| `<C-LeftMouse>` | Smart goto: definition, or references when already on it | keymaps.lua |
| `<localleader>sR` | Structural search & replace | editor/ssr.lua |
| `zR` / `zM` / `zk` | Open all / close all / peek fold | ui/folding.lua |
| `$` ↔ `g_`, `<C-u>`/`<C-d>` 10 lines, `<C-e>`/`<C-y>` 3 lines, `<A-Up/Down>` move line | personal habits | keymaps.lua |

### Intentionally dropped (vs. the pre-ADE config)

- `[E` / `]E` error-only jumps: LazyVim's `[e` / `]e` do the same.
- `<leader>cl` LspInfo: LazyVim's `<leader>cl` already opens the LSP config picker.
- glance.nvim (`gld` / `glr`): `gd` / `gr` with the Snacks picker cover it.
- aerial's `{` / `}` symbol jumps: they shadowed paragraph motions; use `<leader>cs` outline or `<leader>ss` instead.
- The rust extra's `<leader>cR` Rust code-action menu: it shadowed LazyVim's Rename File; `<leader>ca` covers it.

## Conventions

- Each file in `lua/plugins/**` returns one lazy.nvim spec or a list of specs, with a one-line header comment saying what it is for.
- Plugin-specific keys live in that plugin's spec (`keys = {...}`); cross-cutting keys live in `lua/config/keymaps.lua`.
- Plugin versions are locked in `lazy-lock.json`. Spell dictionary: `cspell.json` + `nvim.txt`. LSP project config: `.neoconf.json`.
