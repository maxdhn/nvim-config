local M = {}

function M.options()
  local default = require "nvchad.configs.nvimtree"

  return vim.tbl_deep_extend("force", default, {
    view = {
      adaptive_size = true,
    },
  })
end

return M
