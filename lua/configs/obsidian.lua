return {
  workspaces = {
    { name = "personal", path = "~/vaults/personal" },
    {
      name = "dynamic",
      path = function()
        return assert(vim.fn.getcwd())
      end,
    },
  },

  legacy_commands = false,

  completion = {
    nvim_cmp = true,
  },

  picker = {
    name = "telescope",
  },

  ui = {
    enable = false,
  },
}
