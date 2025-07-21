local plugin_files = {
  "plugins.lsp",
  "plugins.editor",
  "plugins.editor_support",
  "plugins.file_explorer",
  "plugins.git",
  "plugins.session",
  "plugins.telescope",
  "plugins.db",
  "plugins.ai",
  "plugins.diagnostic",
  "plugins.fold",
  "plugins.motion",
  "plugins.workflow",
  "plugins.comment",
  "plugins.debugger",
  -- "plugins.proxy",
}

local function load_plugin_from_file(file)
  local ok, plugins = pcall(require, file)
  if not ok then
    vim.notify("Failed to load plugins from file : " .. file .. ", plugins : " .. plugins, vim.log.levels.ERROR)
    return {}
  end
  return plugins
end

local function merge_plugins_from_files(files)
  local merged_plugins = {}
  for _, file in ipairs(files) do
    local plugins = load_plugin_from_file(file)
    for _, plugin in ipairs(plugins) do
      table.insert(merged_plugins, plugin)
    end
  end
  return merged_plugins
end

local function setup_plugins()
  local plugins = merge_plugins_from_files(plugin_files)
  return plugins
end

return setup_plugins()
