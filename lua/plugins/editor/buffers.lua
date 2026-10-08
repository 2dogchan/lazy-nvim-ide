-- Automatically close buffers that have been inactive for 30 minutes, so the tab bar stays short.
return {
  "chrisgrieser/nvim-early-retirement",
  event = "VeryLazy",
  opts = { retirementAgeMins = 30 },
}
