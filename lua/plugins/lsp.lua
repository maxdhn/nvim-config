return {
  {
    -- The repo moved to mason-org/; NvChad already declares it under that
    -- name, so use the same one to avoid two specs fighting over the clone.
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
    opts = {},
  },

  {
    -- mason.nvim itself has NO `ensure_installed` option -- a list passed to
    -- it is silently ignored. This plugin is what actually installs things.
    -- Names below are mason *package* names (`:Mason` shows them), which are
    -- not always the lspconfig server name used in configs/lspconfig.lua.
    -- Debug adapters are handled separately by mason-nvim-dap in
    -- plugins/debugger.lua, so they do not belong here.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- Language servers
          "ansible-language-server",
          "arduino-language-server",
          "bash-language-server",
          "cmake-language-server",
          "css-lsp",
          "css-variables-language-server",
          "cssmodules-language-server",
          "custom-elements-languageserver",
          "docker-compose-language-service",
          "dockerfile-language-server",
          "emmet-ls",
          "graphql-language-service-cli",
          "html-lsp",
          "java-language-server",
          "json-lsp",
          "lua-language-server",
          "markdown-oxide",
          "nginx-language-server",
          "postgres-language-server", -- provides `postgres_lsp`
          "python-lsp-server",
          "rust-analyzer",
          "sqlls",
          "stylelint-lsp",
          "svelte-language-server",
          "tailwindcss-language-server",
          "terraform-ls",
          "typescript-language-server",
          "vim-language-server",
          "yaml-language-server",

          -- Formatters
          "biome",
          "prettierd",
          "sqlfmt",
          "stylua",

          -- Linters
          "eslint_d",
          "stylelint",
          "write-good",
      },
        -- `run_on_start` is driven by a VimEnter autocmd in the plugin's
        -- plugin/ directory, which never fires for a lazy-loaded plugin.
        -- We trigger the check ourselves below instead.
        run_on_start = false,
        -- Only install what is missing; upgrading is a deliberate
        -- :MasonToolsUpdate, not something that happens under you at startup.
        auto_update = false,
      }

      -- Deferred so installing never blocks the first buffer.
      vim.defer_fn(function()
        require("mason-tool-installer").check_install(false)
      end, 2000)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    keys = {
      -- LSP Mappings
      { "<leader>li", ":LspInfo<CR>", desc = "LSP Info", noremap = true, silent = true },
      {
        "K",
        "<cmd>lua vim.lsp.buf.hover({ border = 'single', max_height = 25, max_width = 120 })<CR>",
        desc = "Hover Documentation",
        noremap = true,
        silent = true,
      },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format Document", noremap = true, silent = true },
      {
        "<leader>ld",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        desc = "Line Diagnostics",
        noremap = true,
        silent = true,
      },
      {
        "<leader>lD",
        "<cmd>lua vim.diagnostic.setloclist()<CR>",
        desc = "All Diagnostics",
        noremap = true,
        silent = true,
      },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Actions", noremap = true, silent = true },
      {
        "<leader>lh",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        desc = "Signature Help",
        noremap = true,
        silent = true,
      },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename", noremap = true, silent = true },
      {
        "<leader>lG",
        "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
        desc = "Workspace Symbols",
        noremap = true,
        silent = true,
      },
      { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic", noremap = true, silent = true },
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous Diagnostic", noremap = true, silent = true },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration", noremap = true, silent = true },
      { "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type Definition", noremap = true, silent = true },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition", noremap = true, silent = true },
      { "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation", noremap = true, silent = true },
      { "grr", ":Telescope lsp_references<CR>", desc = "References", noremap = true, silent = true },
      { "<leader>lR", ":Telescope lsp_references<CR>", desc = "References", noremap = true, silent = true },
      { "gr.", ":Telescope resume<CR>", desc = "Resume Last Telescope", noremap = true, silent = true },
      {
        "<leader>ls",
        ":Telescope lsp_document_symbols<CR>",
        desc = "LSP Document Symbols",
        noremap = true,
        silent = true,
      },
      {
        "<leader>lG",
        ":Telescope lsp_workspace_symbols<CR>",
        desc = "LSP Workspace Symbols",
        noremap = true,
        silent = true,
      },
    },
  },
}
