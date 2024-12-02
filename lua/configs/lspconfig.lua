-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "ansiblels",
  "arduino_language_server",
  "bashls",
  "cmake",
  "cssls",
  "cssmodules_ls",
  "css_variables",
  "dockerls",
  "docker_compose_language_service",
  "graphql",
  "html",
  "java_language_server",
  "jsonls",
  "markdown_oxide",
  "nginx_language_server",
  "postgres_lsp",
  "rust_analyzer",
  "svelte",
  "tailwindcss",
  "terraformls",
  "ts_ls",
  "vimls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
