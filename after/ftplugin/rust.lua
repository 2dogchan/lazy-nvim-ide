-- rust中设置缩进为2
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.expandtab = true

-- 如果最后一个字符不为分号就插入分号,是分号就删除
vim.keymap.set({ "i", "n" }, "<A-enter>", function()
  local line = vim.api.nvim_get_current_line()
  -- Check the line ends with semicolon
  if string.match(line, ".*;$") then
    line = line:sub(1, -2)
  else
    line = line .. ";"
  end
  vim.api.nvim_set_current_line(line)
end)
