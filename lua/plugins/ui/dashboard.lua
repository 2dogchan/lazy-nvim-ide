-- Start screen (snacks.dashboard, LazyVim's default). Only the header is customised; the key list is LazyVim's.
return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 █████╗ ██████╗ ███████╗
██╔══██╗██╔══██╗██╔════╝
███████║██║  ██║█████╗
██╔══██║██║  ██║██╔══╝
██║  ██║██████╔╝███████╗
╚═╝  ╚═╝╚═════╝ ╚══════╝

AI · review · rust · go · flutter]],
      },
    },
  },
}
