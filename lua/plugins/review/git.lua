-- Git while reviewing: colored gutter bars, inline blame on the current line, and Diffview for
-- walking through everything an AI session changed.
--
-- LazyVim already provides: <leader>gg lazygit, <leader>gb blame line, <leader>gd hunk picker,
-- <leader>gh… hunk stage/reset/preview, ]h / [h next/prev hunk.
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      numhl = true,
      -- Who touched this line, and in which commit. Toggle with <leader>uB.
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> · <summary>",
    },
    init = function()
      -- Brighter sign colors than the theme default
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local add, change, delete = "#98c379", "#61afef", "#e06c75"
          for suffix, color in pairs({
            Add = add,
            Change = change,
            Delete = delete,
            Changedelete = change,
            Untracked = add,
          }) do
            vim.api.nvim_set_hl(0, "GitSigns" .. suffix, { fg = color })
            vim.api.nvim_set_hl(0, "GitSigns" .. suffix .. "Nr", { fg = color })
          end
        end,
      })
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gv",
        function()
          if require("diffview.lib").get_current_view() then
            vim.cmd("DiffviewClose")
          else
            vim.cmd("DiffviewOpen")
          end
        end,
        desc = "Diffview (working tree)",
      },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gH", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Line History" },
    },
  },
}
