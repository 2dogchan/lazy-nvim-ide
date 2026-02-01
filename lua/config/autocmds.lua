-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Fixes Autocomment
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-float",
    "httpResult",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-terminal",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bdelete!<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable heavy features for large files
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(event)
    local max_filesize = 512 * 1024 -- 512 KB
    local ok, stats = pcall(vim.uv.fs_stat, event.match)
    if ok and stats and stats.size > max_filesize then
      vim.b[event.buf].bigfile = true
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.schedule(function()
        vim.bo[event.buf].syntax = ""
        -- Detach LSP clients from this buffer
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
          vim.lsp.buf_detach_client(event.buf, client.id)
        end
      end)
    end
  end,
})

-- 设置进入命令模式后不区分大小写
vim.api.nvim_create_autocmd("CmdLineEnter", { command = "set nosmartcase" })
vim.api.nvim_create_autocmd("CmdLineLeave", { command = "set smartcase" })
