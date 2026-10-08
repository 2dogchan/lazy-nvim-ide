-- Custom keymaps. Loaded on VeryLazy, after LazyVim's defaults:
-- https://www.lazyvim.org/keymaps
--
-- Rule of thumb: LazyVim's defaults are kept as-is (gd / gr / gI / gy / K, <leader>c…, <leader>g…,
-- <leader>s…, <leader>x…, <leader>a… for Claude). Everything below is either a personal habit or a
-- review helper that LazyVim does not provide. Plugin-specific keys live next to their plugin spec.

local map = vim.keymap.set

-- ───────────────────────────────── Movement & scrolling ─────────────────────────────────
-- `$` stops at the last non-blank, `g_` goes to the true end of line
map({ "n", "v" }, "$", "g_")
map({ "n", "v" }, "g_", "$")
-- Half-page keys move a fixed 10 lines, so the cursor never jumps unpredictably
map("n", "<C-u>", "10k", { silent = true })
map("n", "<C-d>", "10j", { silent = true })
-- Scroll the view 3 lines at a time
map("n", "<C-e>", "3<C-e>", { silent = true })
map("n", "<C-y>", "3<C-y>", { silent = true })

-- ───────────────────────────────────── Editing ──────────────────────────────────────────
-- Paste over a selection without clobbering the unnamed register
map("v", "p", '"_dP', { silent = true })
-- Move lines with Alt+Arrow (LazyVim already has Alt+j/k)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down", silent = true })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up", silent = true })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down", silent = true })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up", silent = true })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down", silent = true })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up", silent = true })
-- Accept the first spelling suggestion
map("n", "z0", "1z=", { desc = "Fix Word Under Cursor" })

-- `q` is disabled by default so a stray press never starts recording a macro. <leader>uq re-enables it.
map("n", "q", "<Nop>")
Snacks.toggle({
  name = "Macro Recording (q)",
  get = function()
    return vim.g.q_record_macro == true
  end,
  set = function(state)
    vim.g.q_record_macro = state
    map("n", "q", state and "q" or "<Nop>")
  end,
}):map("<leader>uq")

-- ────────────────────────────────── Buffers & dashboard ─────────────────────────────────
-- Shift+Q closes the current buffer; fall back to the dashboard when nothing named is left
map("n", "<S-q>", function()
  Snacks.bufdelete()
  vim.schedule(function()
    local named = vim.tbl_filter(function(b)
      return b.name ~= ""
    end, vim.fn.getbufinfo({ buflisted = 1 }))
    if #named == 0 then
      Snacks.dashboard.open()
    end
  end)
end, { desc = "Close Buffer" })

-- <leader>; wipes every non-terminal buffer and shows the dashboard
map("n", "<leader>;", function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype ~= "terminal" then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
  Snacks.dashboard.open()
end, { desc = "Dashboard" })

-- ──────────────────────────────────── Review helpers ────────────────────────────────────
-- Ctrl+Click: jump to definition, or list references when already on the definition
map("n", "<C-LeftMouse>", function()
  local mouse = vim.fn.getmousepos()
  if mouse.winid ~= 0 then
    vim.api.nvim_set_current_win(mouse.winid)
  end
  if mouse.line > 0 then
    vim.api.nvim_win_set_cursor(0, { mouse.line, math.max(0, mouse.column - 1) })
  end

  local client = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/definition" })[1]
  if not client then
    return
  end
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request("textDocument/definition", params, function(err, result)
    local show = Snacks.picker.lsp_definitions
    if err or not result or vim.tbl_isempty(result) then
      show = Snacks.picker.lsp_references
    else
      local def = vim.islist(result) and result[1] or result
      local uri = def.uri or def.targetUri
      local range = def.range or def.targetSelectionRange
      if uri == vim.uri_from_bufnr(0) and range and range.start.line == mouse.line - 1 then
        show = Snacks.picker.lsp_references
      end
    end
    vim.schedule(show)
  end, 0)
end, { desc = "Smart Goto (Definition / References)" })

-- Only show errors (hide warnings/hints) while skimming a noisy file
Snacks.toggle({
  name = "Errors Only",
  get = function()
    return vim.g.diagnostics_errors_only == true
  end,
  set = function(state)
    vim.g.diagnostics_errors_only = state
    local severity = state and { min = vim.diagnostic.severity.ERROR } or nil
    local cfg = vim.diagnostic.config()
    cfg.underline = severity and { severity = severity } or true
    if type(cfg.signs) == "table" then
      cfg.signs.severity = severity
    end
    if type(cfg.virtual_text) == "table" then
      cfg.virtual_text.severity = severity
    end
    vim.diagnostic.config(cfg)
  end,
}):map("<leader>ux")

-- Inline git blame on the current line (on by default, see review/git.lua). <leader>uG is LazyVim's git signs toggle.
Snacks.toggle({
  name = "Line Blame",
  get = function()
    -- gitsigns has no public getter; fall back to "on" (our default) if the internal path ever moves
    local ok, cfg = pcall(require, "gitsigns.config")
    return not ok or cfg.config.current_line_blame ~= false
  end,
  set = function(state)
    require("gitsigns").toggle_current_line_blame(state)
  end,
}):map("<leader>uB")

-- Pick only FIXME comments (LazyVim's <leader>st shows every TODO keyword)
map("n", "<leader>xf", function()
  Snacks.picker.todo_comments({ keywords = { "FIX", "FIXME" } })
end, { desc = "FIXME Comments" })
