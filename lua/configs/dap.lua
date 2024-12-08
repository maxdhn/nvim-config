-- 1. Set up dap-vscode-js first
-- require("dap-vscode-js").setup {
--   debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
--   adapters = { "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" },
-- }

-- 2. Then configure dap (after adapters are registered)
local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = 8123,
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
      "8123",
    },
  },
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug NestJS App (main.ts)",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--inspect",
      "-r",
      "ts-node/register",
      "-r",
      "tsconfig-paths/register",
      "src/main.ts",
    },
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**" },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to NestJS (Inspect)",
    address = "localhost",
    port = 9229, -- Ensure this is a number, not a string
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    skipFiles = { "<node_internals>/**" },
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Jest (Current File)",
    runtimeExecutable = "node",
    runtimeArgs = {
      "./node_modules/.bin/jest",
      "${file}",
      "--runInBand",
    },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
}

-- Optional: reuse for JavaScript
dap.configurations.javascript = dap.configurations.typescript
