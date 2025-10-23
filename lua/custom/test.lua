local M = {}

function M.toggle_source_test()
  local filename = vim.fn.expand "%:t:r" -- Get the base name without extension
  local file_ext = vim.fn.expand "%:e" -- Get the file extension
  local current_file = vim.fn.expand "%:t" -- Get the current file name with extension
  
  -- Check if current file is a test file (contains 'test' or 'spec')
  local is_test_file = current_file:lower():find("test") or current_file:lower():find("spec")
  
  -- Build search pattern
  local pattern
  if is_test_file then
    -- Remove test/spec indicators to find source file
    local base_name = filename:gsub("[._-]?test$", ""):gsub("[._-]?spec$", "")
    pattern = base_name .. "." .. file_ext
  else
    -- Find test files with same base name
    pattern = "*" .. filename .. "*"
  end
  
  -- Search for matching files in the project
  local found_files = vim.fn.globpath(vim.fn.getcwd(), "**/" .. pattern, false, true)
  
  -- Filter results based on whether we're looking for test or source files
  local filtered_files = {}
  for _, file in ipairs(found_files) do
    local file_name = vim.fn.fnamemodify(file, ":t")
    local has_test_or_spec = file_name:lower():find("test") or file_name:lower():find("spec")
    
    if is_test_file then
      -- Looking for source file (no test/spec in name)
      if not has_test_or_spec then
        table.insert(filtered_files, file)
      end
    else
      -- Looking for test file (has test/spec in name)
      if has_test_or_spec then
        table.insert(filtered_files, file)
      end
    end
  end
  
  -- Handle results
  if #filtered_files == 0 then
    print "No corresponding file found."
  elseif #filtered_files == 1 then
    vim.cmd("edit " .. filtered_files[1])
  else
    -- Try to use Telescope if available, otherwise fallback to vim.ui.select
    local ok, telescope = pcall(require, "telescope")
    
    if ok then
      -- Use Telescope for file selection with preview
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local previewers = require("telescope.previewers")
      
      pickers.new({}, {
        prompt_title = is_test_file and "Select Source File" or "Select Test File",
        finder = finders.new_table {
          results = filtered_files,
          entry_maker = function(entry)
            return {
              value = entry,
              display = vim.fn.fnamemodify(entry, ":~:."),
              ordinal = vim.fn.fnamemodify(entry, ":~:."),
            }
          end,
        },
        sorter = conf.file_sorter({}),
        previewer = previewers.vim_buffer_cat.new({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              vim.cmd("edit " .. selection.value)
            end
          end)
          return true
        end,
      }):find()
    else
      -- Fallback to vim.ui.select
      vim.ui.select(filtered_files, {
        prompt = "Select file:",
        format_item = function(item)
          return vim.fn.fnamemodify(item, ":~:.")
        end,
      }, function(choice)
        if choice then
          vim.cmd("edit " .. choice)
        end
      end)
    end
  end
end

return M
