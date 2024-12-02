return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup {
        automatic_installation = false,
        ensure_installed = { "python", "js@v1.76.1" },
      }
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    keys = {
      { "<leader>tn", ":lua require('neotest').run.run()<CR>", desc = "Run nearest test", noremap = true, silent = true },
      { "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run file tests" },
      { "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      { "<F5>", ":lua require'dap'.continue()<CR>", desc = "Start/Continue Debugging" },
      { "<F10>", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
      { "<F11>", ":lua require'dap'.step_into()<CR>", desc = "Step Into" },
      { "<F12>", ":lua require'dap'.step_out()<CR>", desc = "Step Out" },
      { "<Leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
      { "<Leader>dc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Set Conditional Breakpoint" },
      { "<Leader>dr", ":lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
      { "<Leader>dl", ":lua require'dap'.run_last()<CR>", desc = "Run Last Debugging Session" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      { "<Leader>du", ":lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI" },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
