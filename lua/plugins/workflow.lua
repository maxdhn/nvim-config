return {
  {
    "tris203/precognition.nvim",
    event = "BufRead",
    config = function()
      require("precognition").setup {
        -- Custom configuration
        highlight = true, -- Enable highlight
        autocmds = true, -- Enable autocmds
        keymaps = {
          toggle = "<Leader>pc", -- Keymap to toggle precognition
        },
      }
    end,
    keys = {
      { "<Leader>pc", ":lua require('precognition').toggle()<CR>", desc = "Toggle Precognition", noremap = true, silent = true },
    },
  },
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
    -- keys = {
    --   -- Example of adding restricted keys if needed dynamically
    --   -- Add key mappings specific to `hardtime.nvim` as needed here
    -- },
  },
}
