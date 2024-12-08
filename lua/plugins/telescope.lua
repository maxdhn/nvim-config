return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      -- vim.api.nvim_del_keymap("n", "<leader>fa")
      -- vim.api.nvim_del_keymap("n", "<leader>fh")
      local config = require "configs.telescope"
      -- config.path_display = { "smart " }
      return config
    end,
    keys = {
      {
        "<leader>fF",
        ":Telescope find_files hidden=true<CR>",
        desc = "Find files (include hidden files)",
        noremap = true,
        silent = true,
        mode = "n",
      },
      {
        "<leader>fW",
        ":Telescope live_grep hidden=true path_display={'smart'}<CR>",
        desc = "Live Grep (include hidden files)",
        noremap = true,
        silent = true,
        mode = "n",
      },
    },
  },
}
