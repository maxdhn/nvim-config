return {

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      local dap = require "dap"
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }

      local js_based_languages = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }

      for _, lang in ipairs(js_based_languages) do
        dap.configurations[lang] = {

          {
            type = "node2",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },

          {
            type = "node2",
            request = "attach",
            name = "Attach to process",
            -- processId = function()
            --   return require("dap.utils").pick_process { filter = "node" }
            -- end,
            port = 9229,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
          },

          {
            type = "node2",
            request = "launch",
            name = "Jest current file",
            cwd = vim.fn.getcwd(),
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "${fileBasenameNoExtension}",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            console = "integratedTerminal",
            sourceMaps = true,
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
    keys = {
      { "<F5>", ":lua require'dap'.continue()<CR>", desc = "Start/Continue Debugging" },
      { "<F10>", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
      { "<F11>", ":lua require'dap'.step_into()<CR>", desc = "Step Into" },
      { "<F12>", ":lua require'dap'.step_out()<CR>", desc = "Step Out" },
      { "<Leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
      {
        "<Leader>dc",
        ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        desc = "Set Conditional Breakpoint",
      },
      { "<Leader>dr", ":lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
      { "<Leader>dl", ":lua require'dap'.run_last()<CR>", desc = "Run Last Debugging Session" },
    },
  },

  -- UI (sidebar, REPL, scopes, breakpoints, etc.) -----------------------------
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      dapui.setup {
        layouts = {
          { -- left sidebar
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 40,
            position = "left",
          },
          { -- bottom panel
            elements = { "repl", "console" },
            size = 10,
            position = "bottom",
          },
        },
        controls = { enabled = true },
      }

      -- Auto-open/close UI on session start/stop -------------------------
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
  },

  -- Virtual text inline variable values ---------------------------------------
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = { commented = true },
  },

  -- One-command adapter installation -----------------------------------------
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      automatic_installation = true,
      ensure_installed = { "node2" }, -- pulls VS Code node debug adapter
    },
  },

  -- Telescope integration (:Telescope dap commands/frames/…) ------------------
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("telescope").load_extension "dap"
    end,
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
      {
        "<leader>tn",
        ":lua require('neotest').run.run()<CR>",
        desc = "Run nearest test",
        noremap = true,
        silent = true,
      },
      { "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run file tests" },
      { "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary" },
    },
  },
}

-- return {
--   -- DAP Adapter Installer
--   {
--     "jay-babu/mason-nvim-dap.nvim",
--     dependencies = { "mfussenegger/nvim-dap" },
--     config = function()
--       require("mason-nvim-dap").setup {
--         automatic_installation = false,
--         ensure_installed = { "python", "js@v1.76.1" },
--       }
--     end,
--   },
--   {
--     "mxsdev/nvim-dap-vscode-js",
--     dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
--     config = function()
--       require "configs.dap"
--     end,
--   },
--   {
--     "mfussenegger/nvim-dap",
--     lazy = true,
--     keys = {
--       { "<F5>", ":lua require'dap'.continue()<CR>", desc = "Start/Continue Debugging" },
--       { "<F10>", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
--       { "<F11>", ":lua require'dap'.step_into()<CR>", desc = "Step Into" },
--       { "<F12>", ":lua require'dap'.step_out()<CR>", desc = "Step Out" },
--       { "<Leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
--       {
--         "<Leader>dc",
--         ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
--         desc = "Set Conditional Breakpoint",
--       },
--       { "<Leader>dr", ":lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
--       { "<Leader>dl", ":lua require'dap'.run_last()<CR>", desc = "Run Last Debugging Session" },
--     },
--   },
--   {
--     "rcarriga/nvim-dap-ui",
--     dependencies = {
--       "nvim-neotest/nvim-nio",
--       "mfussenegger/nvim-dap",
--     },
--     config = function()
--       local dap, dapui = require "dap", require "dapui"
--       dapui.setup()
--
--       dap.listeners.after.event_initialized["dapui_config"] = function()
--         dapui.open()
--       end
--       dap.listeners.before.event_terminated["dapui_config"] = function()
--         dapui.close()
--       end
--       dap.listeners.before.event_exited["dapui_config"] = function()
--         dapui.close()
--       end
--     end,
--     keys = {
--       { "<Leader>du", ":lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI" },
--     },
--   },
--
--   -- Virtual text for variables
--   {
--     "theHamsta/nvim-dap-virtual-text",
--     dependencies = { "mfussenegger/nvim-dap" },
--     config = function()
--       require("nvim-dap-virtual-text").setup()
--     end,
--   },
--   {
--     "nvim-neotest/neotest",
--     dependencies = {
--       "nvim-neotest/neotest-jest",
--       "nvim-neotest/nvim-nio",
--       "nvim-lua/plenary.nvim",
--       "antoinemadec/FixCursorHold.nvim",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--       require("neotest").setup {
--         adapters = {
--           require "neotest-jest" {
--             jestConfigFile = "jest.config.ts",
--             env = { CI = true },
--             cwd = function(path)
--               return vim.fn.getcwd()
--             end,
--           },
--         },
--       }
--     end,
--     keys = {
--       {
--         "<leader>tn",
--         ":lua require('neotest').run.run()<CR>",
--         desc = "Run nearest test",
--         noremap = true,
--         silent = true,
--       },
--       { "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run file tests" },
--       { "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary" },
--     },
--   },
-- }
