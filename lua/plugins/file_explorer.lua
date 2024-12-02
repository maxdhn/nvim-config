return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "file_browser"
    end,
    keys = {
      { 
        "<leader>fb", 
        ":Telescope file_browser<CR>", 
        desc = "Open File Browser", 
        noremap = true, 
        silent = true 
      },
      {
        "<leader>fB",
        ":lua vim.cmd('Telescope file_browser cwd=' .. vim.fn.expand('%:p:h'))<CR>",
        desc = "Open File Browser at Buffer's Directory",
        noremap = true,
        silent = true,
      },
    },
  },
}
