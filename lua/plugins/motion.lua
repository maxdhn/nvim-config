return {
  {
    "kwkarlwang/bufjump.nvim",
    config = function()
      require("bufjump").setup({
        forward_key = "<C-i>",
        backward_key = "<C-o>",
        on_success = nil
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    keys = {
      {
        "<C-d>",
        function()
          require("neoscroll").scroll(5, { move_cursor = true, duration = 100 })
        end,
        desc = "Scroll down",
        mode = "n",
      },
      {
        "<C-u>",
        function()
          require("neoscroll").scroll(-5, { move_cursor = true, duration = 100 })
        end,
        desc = "Scroll up",
        mode = "n",
      },
    },
    opts = {
      -- Custom mappings are defined in `keys` above, so don't set the defaults
      mappings = {},
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
