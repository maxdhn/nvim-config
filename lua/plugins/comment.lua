return {
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    "jeangiraldoo/codedocs.nvim",
    -- Remove the 'dependencies' section if you don't plan on using nvim-treesitter
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
