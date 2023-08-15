local dap = require("dap")

return {
  "mfussenegger/nvim-dap",

  keys = {
    { "<F6>", dap.step_out, desc = "Step Out" },
    { "<F7>", dap.step_into, desc = "Step Into" },
    { "<F8>", dap.step_over, desc = "Step Over" },
    { "<F9>", dap.continue, desc = "Continue" },
    { "<leader>dh", require("dap.ui.widgets").hover, desc = "Hover" },
  },
}
