return {
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      for i, adapter in ipairs(opts.adapters) do
        if type(adapter) == "table" and adapter[1] == "neotest-golang" then
          adapter[2] = vim.tbl_deep_extend("force", adapter[2] or {}, { warn_test_name_dupes = false })
          return
        end
      end
    end,
  },
}
