return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI: sidebar, repl, scopes, breakpoints. nvim-nio is a hard requirement
      -- of dap-ui and must be declared here, not inherited from neotest.
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {
          layouts = {
            {
              elements = { "scopes", "breakpoints", "stacks", "watches" },
              size = 40,
              position = "left",
            },
            {
              elements = { "repl", "console" },
              size = 10,
              position = "bottom",
            },
          },
          controls = { enabled = true, element = "repl" },
          floating = { border = "rounded" },
        },
      },

      -- Inline variable values next to the code
      { "theHamsta/nvim-dap-virtual-text", opts = { commented = true } },

      -- Adapter installation. NOTE: the key is the mason-nvim-dap *source*
      -- name ("js"), NOT the mason package name ("js-debug-adapter") --
      -- unknown names are silently ignored.
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
          ensure_installed = { "js" },
          handlers = {
            -- We register pwa-node/pwa-chrome ourselves below, so opt out of
            -- the automatic setup that would otherwise overwrite it when the
            -- package finishes installing.
            js = function() end,
          },
        },
      },
    },

    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      ------------------------------------------------------------------
      -- Adapters
      ------------------------------------------------------------------
      -- The mason bin shim already points at js-debug/src/dapDebugServer.js,
      -- so this survives js-debug-adapter's internal layout changing.
      local js_debug = vim.fn.stdpath "data" .. "/mason/bin/js-debug-adapter"

      for _, adapter in ipairs { "pwa-node", "pwa-chrome" } do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = { command = js_debug, args = { "${port}" } },
        }
      end

      ------------------------------------------------------------------
      -- Shared config for every node-based launch/attach
      ------------------------------------------------------------------
      local node_defaults = {
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        -- Keeps js-debug from chasing source maps into dependencies. If you
        -- work in a monorepo with symlinked local packages, drop the negation.
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
      }

      local function node_config(cfg)
        return vim.tbl_extend("keep", cfg, node_defaults)
      end

      local function input_url()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
            if url and url ~= "" then
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      ------------------------------------------------------------------
      -- Configurations
      ------------------------------------------------------------------
      local configs = {
        -- NestJS ------------------------------------------------------
        node_config {
          type = "pwa-node",
          request = "attach",
          name = "Nest: attach to running app (:9229)",
          address = "localhost",
          port = 9229,
          restart = true,
          -- Nest compiles to dist/; this is where the source maps live.
          outFiles = { "${workspaceFolder}/dist/**/*.js", "!**/node_modules/**" },
        },
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Nest: launch (npm run start:debug)",
          runtimeExecutable = "npm",
          runtimeArgs = { "run", "start:debug" },
          -- `nest start --debug --watch` re-spawns node on every change.
          autoAttachChildProcesses = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          outFiles = { "${workspaceFolder}/dist/**/*.js", "!**/node_modules/**" },
        },
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Nest: launch src/main.ts (ts-node)",
          runtimeExecutable = "node",
          runtimeArgs = {
            "-r",
            "ts-node/register",
            "-r",
            "tsconfig-paths/register",
            "${workspaceFolder}/src/main.ts",
          },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Nest: debug e2e tests",
          runtimeExecutable = "npm",
          runtimeArgs = { "run", "test:e2e", "--", "--runInBand" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },

        -- Jest --------------------------------------------------------
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Jest: debug current file",
          runtimeExecutable = "node",
          runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "${file}", "--runInBand" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Jest: debug all tests",
          runtimeExecutable = "node",
          runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest", "--runInBand" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },

        -- Plain node / TS --------------------------------------------
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Node: launch current file",
          program = "${file}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        node_config {
          type = "pwa-node",
          request = "launch",
          name = "Node: launch current file (tsx)",
          runtimeExecutable = "npx",
          runtimeArgs = { "tsx", "${file}" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        node_config {
          type = "pwa-node",
          request = "attach",
          name = "Node: attach to process...",
          processId = require("dap.utils").pick_process,
        },

        -- Browser -----------------------------------------------------
        node_config {
          type = "pwa-chrome",
          request = "launch",
          name = "Chrome: launch & debug",
          url = input_url,
          webRoot = "${workspaceFolder}",
          userDataDir = false,
        },
      }

      local js_based_languages = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      }

      for _, lang in ipairs(js_based_languages) do
        dap.configurations[lang] = configs
      end

      -- NOTE: .vscode/launch.json is picked up automatically on every
      -- dap.continue() by nvim-dap's "dap.launch.json" config provider.
      -- Do not call dap.ext.vscode.load_launchjs -- it is deprecated and
      -- would duplicate every entry into dap.configurations.

      ------------------------------------------------------------------
      -- Signs
      ------------------------------------------------------------------
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine" })

      ------------------------------------------------------------------
      -- Auto open/close the UI
      ------------------------------------------------------------------
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
      -- Stepping
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },

      -- Breakpoints
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      {
        "<leader>dc",
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
            if cond and cond ~= "" then
              require("dap").set_breakpoint(cond)
            end
          end)
        end,
        desc = "Debug: Conditional Breakpoint",
      },
      {
        "<leader>dp",
        function()
          vim.ui.input({ prompt = "Log point message: " }, function(msg)
            if msg and msg ~= "" then
              require("dap").set_breakpoint(nil, nil, msg)
            end
          end)
        end,
        desc = "Debug: Log Point",
      },
      { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "Debug: Clear Breakpoints" },

      -- Session
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debug: Run to Cursor" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Terminate" },

      -- UI
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      {
        "<leader>de",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        mode = { "n", "v" },
        desc = "Debug: Eval",
      },
    },
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
            jestConfigFile = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
              end
              return vim.fn.getcwd() .. "/jest.config.js"
            end,
            env = { CI = true },
            cwd = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src")
              end
              return vim.fn.getcwd()
            end,
          },
        },
        discovery = { enabled = false },
      }
    end,
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      {
        "<leader>to",
        function()
          require("neotest").output.open { enter = true, auto_close = true }
        end,
        desc = "Show test output",
      },
      -- Moved off <leader>td, which collides with TodoTrouble in diagnostic.lua
      {
        "<leader>dt",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        desc = "Debug: Nearest Test",
      },
    },
  },
}
