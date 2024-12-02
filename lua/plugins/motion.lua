return {
  {
    "karb94/neoscroll.nvim",
    keys = {
      { "<C-d>", desc = "Scroll down", mode = "n" },
      { "<C-u>", desc = "Scroll up", mode = "n" },
    },
    opts = {
      mappings = { "<C-u>", "<C-d>" },
    },
  },
  {
    "smoka7/hop.nvim",
    cmd = { "HopWord", "HopLine", "HopLineStart", "HopWordCurrentLine" },
    opts = { keys = "etovxqpdygfblzhckisuran" },
    keys = {
      { "<leader><leader>w", "<CMD>HopWord<CR>", desc = "Hint all words", mode = "n" },
      { "<leader><leader>t", "<CMD>HopNodes<CR>", desc = "Hint Tree", mode = "n" },
      { "<leader><leader>c", "<CMD>HopLineStart<CR>", desc = "Hint Columns", mode = "n" },
      { "<leader><leader>l", "<CMD>HopWordCurrentLine<CR>", desc = "Hint Line", mode = "n" },
    },
  },
}
