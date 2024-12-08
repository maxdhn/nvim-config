return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      -- vim.api.nvim_del_keymap("n", "<leader>fa")
      -- vim.api.nvim_del_keymap("n", "<leader>fh")
      return require "nvchad.configs.telescope"
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
        ":Telescope live_grep hidden=true<CR>",
        desc = "Live Grep (include hidden files)",
        noremap = true,
        silent = true,
        mode = "n",
      },
    },
  },
}
