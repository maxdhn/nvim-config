local default_config = require "nvchad.configs.telescope"

local telescope_config = {
  defaults = vim.tbl_deep_extend("force", default_config.defaults, {
    path_display = { "filename_first" },
  }),
}

return telescope_config
