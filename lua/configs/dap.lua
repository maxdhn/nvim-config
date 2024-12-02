-- setup adapters
require("dap-vscode-js").setup {
  debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
  debugger_cmd = { "js-debug-adapter" },
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}

local dap = require "dap"
-- TypeScript support
dap.configurations.typescript = {
  {
    name = "Debug Jest File (TypeScript)",
    type = "pwa-node",
    request = "launch",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--inspect-brk",
      "../../node_modules/.bin/jest",
      "${file}", 
      "--runInBand",
      "--coverage=false",
      "--no-cache",
    },
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
  },
}

-- Optional: Setup dap-ui hooks
local dapui = require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
