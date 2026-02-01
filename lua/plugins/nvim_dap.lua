return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function(event)
          if event.data ~= "nvim-dap" then
            return
          end
          local dap = require("dap")
          local orig_run = dap.run
          dap.run = function(config, opts)
            config = vim.deepcopy(config)
            local cwd = vim.fn.getcwd()
            for key, val in pairs(config) do
              if type(val) == "string" then
                config[key] = val:gsub("%${workspaceFolder}", cwd)
              end
            end
            if not config.outputMode then
              config.outputMode = "remote"
            end
            return orig_run(config, opts)
          end
          return true
        end,
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dapui = require("dapui")
      dapui.setup(opts)
      -- Don't auto open/close DAP UI, use <leader>du to toggle manually
    end,
  },
}
