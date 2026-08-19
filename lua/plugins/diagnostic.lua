return {
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>tx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>td",
        "<cmd>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<cr>",
        desc = "Todo/Fix/Fixme",
      },

      -- LSP results in a navigable panel rather than a picker that vanishes.
      -- `lsp` is the combined mode: definitions, references, implementations,
      -- type definitions, declarations and call hierarchy in one window.
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle win.position=right<cr>",
        desc = "LSP References/Definitions (Trouble)",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp_references toggle<cr>",
        desc = "LSP References (Trouble)",
      },
      { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix (Trouble)" },
      { "<leader>tL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    },
  },

  {
    -- Peek definitions/references in a preview window without losing your
    -- place. Complements Telescope (search) and Trouble (triage): this one is
    -- for "what is this thing" without leaving the buffer you are reading.
    "dnlhc/glance.nvim",
    cmd = "Glance",
    opts = {
      height = 18,
      border = { enable = true },
      list = { position = "right", width = 0.33 },
      hooks = {
        -- Don't open the picker for a single result that is already here.
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1])
          else
            open(results)
          end
        end,
      },
    },
    keys = {
      { "gpd", "<cmd>Glance definitions<cr>", desc = "Peek Definitions" },
      { "gpr", "<cmd>Glance references<cr>", desc = "Peek References" },
      { "gpt", "<cmd>Glance type_definitions<cr>", desc = "Peek Type Definitions" },
      { "gpi", "<cmd>Glance implementations<cr>", desc = "Peek Implementations" },
    },
  },
}
