local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- typescript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    -- html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    css = { "stylelint", "stylelint-lsp", stop_after_first = true },
    scss = { "stylelint", "stylelint-lsp", stop_after_first = true },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
