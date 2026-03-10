return {
  {
    "obsidian-nvim/obsidian.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require "configs.obsidian"
    end,
    keys = {
      { "<leader>nn", "<cmd>Obsidian new<CR>", desc = "New note", noremap = true, silent = true },
      { "<leader>nf", "<cmd>Obsidian search<CR>", desc = "Find notes", noremap = true, silent = true },
      { "<leader>no", "<cmd>Obsidian open<CR>", desc = "Open in Obsidian app", noremap = true, silent = true },
      { "<leader>nb", "<cmd>Obsidian backlinks<CR>", desc = "Show backlinks", noremap = true, silent = true },
      { "<leader>nt", "<cmd>Obsidian tags<CR>", desc = "Browse tags", noremap = true, silent = true },
      { "<leader>nl", "<cmd>Obsidian links<CR>", desc = "Show links", noremap = true, silent = true },
      { "<leader>np", "<cmd>Obsidian paste_img<CR>", desc = "Paste image", noremap = true, silent = true },
      { "<leader>nd", "<cmd>Obsidian dailies<CR>", desc = "Daily notes", noremap = true, silent = true },
      { "<leader>ni", "<cmd>Obsidian template<CR>", desc = "Insert template", noremap = true, silent = true },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  {
    "folke/snacks.nvim",
    opts = {
      image = { enabled = true },
    },
  },
}
