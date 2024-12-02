return {
  {
    "haringsrob/nvim_context_vt",
    event = "BufReadPost",
  },
  {
    "matze/vim-move",
    event = "BufReadPost",
    keys = {
      { "<A-j>", "<Plug>MoveLineDown", desc = "Move line down", mode = "n" },
      { "<A-k>", "<Plug>MoveLineUp", desc = "Move line up", mode = "n" },
      { "<A-j>", "<Plug>MoveBlockDown", desc = "Move block down", mode = "v" },
      { "<A-k>", "<Plug>MoveBlockUp", desc = "Move block up", mode = "v" },
      { "<A-h>", "<Plug>MoveCharLeft", desc = "Move char left", mode = "n" },
      { "<A-l>", "<Plug>MoveCharRight", desc = "Move char right", mode = "n" },
      { "<A-h>", "<Plug>MoveBlockLeft", desc = "Move block left", mode = "v" },
      { "<A-l>", "<Plug>MoveBlockRight", desc = "Move block right", mode = "v" },
    },
  },
  {
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist", "TZFocus" },
    config = function()
      require("true-zen").setup {}
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufReadPost",
    config = function()
      require("refactoring").setup {}
    end,
  },
  {
    "bennypowers/nvim-regexplainer",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    event = "BufReadPost",
    config = function()
      require("regexplainer").setup {}
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPost",
  },
  {
    "gbprod/yanky.nvim",
    event = "BufReadPost",
    config = function()
      require("yanky").setup {
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
      }

      require("telescope").load_extension "yank_history"
    end,
    keys = {
      { "<leader>pp", "<cmd>Telescope yank_history<CR>", desc = "Yank history", noremap = true, silent = true },
    },
  },
  {
    "gbprod/cutlass.nvim",
    event = "BufReadPost",
    opts = {
      cut_key = "X",
      override_del = true,
    },
  },
  {
    "windwp/nvim-spectre",
    lazy = false,
    config = function()
      require("spectre").setup()
    end,
    keys = {
      { "<leader>S", ":lua require('spectre').toggle()<CR>", desc = "Toggle Spectre", noremap = true, silent = true },
      { "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search current word" },
      { "<leader>sp", "viw:lua require('spectre').open_file_search()<CR>", desc = "Search on current file" },
    },
  },
  {
    "rainbowhxch/beacon.nvim",
    event = "CursorMoved",
    cond = function()
      return not vim.g.neovide
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = "nvim-treesitter",
    config = function()
      require("illuminate").configure {
        under_cursor = true,
      }
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "lewis6991/satellite.nvim",
    event = "BufWinEnter",
    opts = { excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify", "neo-tree" } },
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle" },
    opts = { use_default_keymaps = false },
    keys = {
      { "ts", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join/Split", mode = "n" },
    },
  },
}
