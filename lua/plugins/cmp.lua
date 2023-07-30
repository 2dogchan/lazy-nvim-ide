return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Add tabnine support
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        -- only limit top 3 suggestions from tabnine
        config = function()
          local tabnine = require("cmp_tabnine.config")
          tabnine:setup({
            max_lines = 1000,
            max_num_results = 3,
            sort = true,
          })
        end,
      },
      {
        "jellydn/codeium.nvim",
        -- NOTE: Use my fork to fix the Codeium Auth issue. Will remove this once the PR is merged.
        branch = "patch-1",
        config = true,
      },
      -- Support Rust
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = true,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- add custom sources
      local sources = {
        -- move codeium to same group as copilot
        { name = "codeium", group_index = 2 },
        { name = "cmp_tabnine", group_index = 3 },
        -- support rust
        { name = "crates" },
      }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))

      -- format the completion menu
      opts.formatting = {
        format = function(entry, vim_item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[vim_item.kind] then
            vim_item.kind = icons[vim_item.kind] .. vim_item.kind
          end

          -- Set a name for each source
          if entry.source.name == "emoji" then
            vim_item.kind = " [Emoji]"
          end

          if entry.source.name == "codeium" then
            vim_item.kind = " [Codeium]"
          end

          -- Add tabnine icon and hide percentage in the menu
          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = " [TabNine]"
            vim_item.menu = ""

            if (entry.completion_item.data or {}).multiline then
              vim_item.kind = vim_item.kind .. " " .. "[ML]"
            end
          end

          local maxwidth = 80
          vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

          return vim_item
        end,
      }
    end,
  },
}
