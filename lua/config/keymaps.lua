local util = require("util")

util.cowboy()

local nav = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function navigate(dir)
  return function()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(dir)
    local pane = vim.env.WEZTERM_PANE
    if pane and win == vim.api.nvim_get_current_win() then
      local pane_dir = nav[dir]
      vim.system({ "wezterm", "cli", "activate-pane-direction", pane_dir }, { text = true }, function(p)
        if p.code ~= 0 then
          vim.notify(
            "Failed to move to pane " .. pane_dir .. "\n" .. p.stderr,
            vim.log.levels.ERROR,
            { title = "Wezterm" }
          )
        end
      end)
    end
  end
end

util.set_user_var("IS_NVIM", true)

-- Move to window using the movement keys
for key, dir in pairs(nav) do
  vim.keymap.set("n", "<" .. dir .. ">", navigate(key))
  vim.keymap.set("n", "<C-" .. key .. ">", navigate(key))
end

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

-- run lua
vim.keymap.set("n", "<leader>cR", util.runlua, { desc = "Run Lua" })

-- Function to toggle 'q' functionality
function _G.toggle_q_macro()
  if vim.g.q_record_macro then
    -- If currently set for recording macros, make 'q' do nothing
    vim.keymap.set("n", "q", "<Nop>", { noremap = true })
    vim.g.q_record_macro = false
  else
    -- If currently set to do nothing, make 'q' record macros
    vim.keymap.set("n", "q", "q", { noremap = true })
    vim.g.q_record_macro = true
  end
end

vim.g.q_record_macro = false

vim.keymap.set(
  "n",
  "<leader>uq",
  "<cmd>lua _G.toggle_q_macro()<CR>",
  { noremap = true, silent = true, desc = "Toggle 'q' Functionality" }
)
vim.keymap.set("n", "q", "<Nop>", { noremap = true })

-- Better paste
-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
vim.keymap.set("v", "p", '"_dP')

-- Copy whole file content to clipboard with C-c
-- keymap("n", "<C-c>", ":%y+<CR>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Fix Spell checking
vim.keymap.set("n", "z0", "1z=", {
  desc = "Fix world under cursor",
})
