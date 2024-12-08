return {
  {
    "m4xshen/hardtime.nvim",
    event = "BufRead",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      max_count = 6,
      restricted_keys = {
        ["<C-N>"] = {},
      },
    },
  },
}
