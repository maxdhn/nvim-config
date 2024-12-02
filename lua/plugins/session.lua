return {
  {
    "olimorris/persisted.nvim",
    lazy = false, -- Always load at startup
    config = function()
      require("persisted").setup()
      require("telescope").load_extension "persisted"
    end,
    keys = {
      { "<leader>fS", ":Telescope persisted<CR>", desc = "Telescope sessions", noremap = true, silent = true }, -- Open session picker
      { "<leader>qs", ":SessionSave<CR>", desc = "Save session", noremap = true, silent = true }, -- Save session
      { "<leader>ql", ":SessionLoad<CR>", desc = "Load session", noremap = true, silent = true }, -- Load session
      { "<leader>qd", ":SessionDelete<CR>", desc = "Delete session", noremap = true, silent = true }, -- Delete session
    },
  },
}
