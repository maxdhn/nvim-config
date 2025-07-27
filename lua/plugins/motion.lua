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
      { "<C-d>", desc = "Scroll down", mode = "n" },
      { "<C-u>", desc = "Scroll up", mode = "n" },
    },
    opts = {
      -- You can list the mappings you want animated here
      mappings = { "<C-u>", "<C-d>" },
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)

      local t = {}
      t["<C-u>"] = { "scroll", { "-5", "true", "100" } }
      t["<C-d>"] = { "scroll", { "5", "true", "100" } }

      require("neoscroll.config").set_mappings(t)
    end,
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
