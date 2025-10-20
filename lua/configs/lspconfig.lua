-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

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
vim.lsp.enable(servers)
