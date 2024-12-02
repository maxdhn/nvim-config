local M = {}

function M.toggle_source_test()
  local current_path = vim.fn.expand "%:p" -- Get the current full file path
  local current_dir = vim.fn.expand "%:p:h" -- Get the current directory
  local filename = vim.fn.expand "%:t" -- Get the file name with extension
  local file_base = vim.fn.expand "%:t:r" -- Get the base name without extension or paths
  local file_ext = vim.fn.expand "%:e" -- Get the file extension

  -- Determine if current file is a test file and construct target file patterns
  local target_patterns
  if filename:find("test", 1, true) then
    -- Current file is a test file, remove test indicators to find source
    target_patterns = {
      file_base:gsub("%.test$", ""),
      file_base:gsub("_test$", ""),
    }
    -- Append extension if present
    for i, pattern in ipairs(target_patterns) do
      if file_ext ~= "" then
        target_patterns[i] = pattern .. "." .. file_ext
      end
    end
  else
    -- Current file is a source file, add test indicators to find test
    target_patterns = { file_base .. ".test", file_base .. "_test" }
    -- Append extension if present
    for i, pattern in ipairs(target_patterns) do
      if file_ext ~= "" then
        target_patterns[i] = pattern .. "." .. file_ext
      end
    end
  end

  -- Function to find files based on patterns in the current directory and project
  local function find_files(patterns)
    for _, pattern in ipairs(patterns) do
      -- Check the current directory first
      local found_files = vim.fn.globpath(current_dir, pattern, false, true)
      if vim.tbl_isempty(found_files) then
        -- If not found, search the entire project directory
        found_files = vim.fn.globpath(vim.fn.getcwd(), "**/" .. pattern, false, true)
      end
      if not vim.tbl_isempty(found_files) then
        return found_files[1] -- Return the first match found
      end
    end
    return nil
  end

  -- Attempt to find the target file
  local target_file = find_files(target_patterns)
  if target_file then
    vim.cmd("edit " .. target_file)
  else
    print "Corresponding file does not exist."
  end
end

return M
