-- Test runner (LazyVim test.core extra: <leader>tt file, <leader>tr nearest, <leader>ts summary).
-- Adapters come from the language extras: neotest-golang, neotest-dart, rustaceanvim.neotest.
return {
  "nvim-neotest/neotest",
  opts = function(_, opts)
    -- At this point opts.adapters is still LazyVim's dict form { ["neotest-golang"] = {...} };
    -- test.core flattens it into a list later, in its own config().
    opts.adapters = opts.adapters or {}
    local go = opts.adapters["neotest-golang"]
    if type(go) == "table" then
      opts.adapters["neotest-golang"] = vim.tbl_deep_extend("force", go, {
        warn_test_name_dupes = false,
        dap_go_enabled = false, -- no debugger in this setup
      })
    end
  end,
}
