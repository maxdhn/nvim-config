return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", ":LazyGit<CR>", desc = "Open LazyGit", mode = "n", noremap = true, silent = true },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    config = function()
      require("diffview").setup {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true, -- Requires nvim-web-devicons
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        numhl = false,
        linehl = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        diff_opts = {
          internal = true, -- If luajit is present
        },
      }
    end,
    keys = {
      { "<leader>gt", ":Telescope git_status<CR>", desc = "Git Status", noremap = true, silent = true },
      { "<leader>gb", ":Telescope git_branches<CR>", desc = "Git Branches", noremap = true, silent = true },
      { "<leader>gc", ":Telescope git_commits<CR>", desc = "Git Commits (repository)", noremap = true, silent = true },
      { "<leader>gC", ":Telescope git_bcommits<CR>", desc = "Git Commits (current file)", noremap = true, silent = true },
      { "]h", ":lua require('gitsigns').next_hunk()<CR>", desc = "Next Git Hunk", noremap = true, silent = true },
      { "[h", ":lua require('gitsigns').prev_hunk()<CR>", desc = "Previous Git Hunk", noremap = true, silent = true },
    },
  },
}
