local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local fb_actions = require "telescope._extensions.file_browser.actions"

function M.live_grep_in_folder()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = "Select Directory",
    path = vim.fn.getcwd(), -- Start in the current working directory
    select_buffer = true,
    hidden = true,
    cwd_to_path = true,
    attach_mappings = function(prompt_bufnr, map)
      local current_dir = vim.fn.getcwd()

      local function set_directory_and_grep()
        local selected_entry = action_state.get_selected_entry()
        local dir = selected_entry.path or current_dir
        actions.close(prompt_bufnr)
        M.live_grep_with_parent_nav(dir)
      end

      local function change_directory()
        local selected_entry = action_state.get_selected_entry()
        if selected_entry and selected_entry.path then
          current_dir = selected_entry.path
          require("telescope.actions").select_default(prompt_bufnr)
        end
      end

      map("i", "<CR>", set_directory_and_grep)
      map("n", "<CR>", set_directory_and_grep)
      map("i", "<C-p>", fb_actions.goto_parent_dir)
      map("n", "<C-p>", fb_actions.goto_parent_dir)
      map("i", "<C-s>", change_directory)
      map("n", "<C-s>", change_directory)

      return true
    end,
  }
end

function M.live_grep_with_parent_nav(cwd)
  require("telescope.builtin").live_grep {
    cwd = cwd,
    attach_mappings = function(prompt_bufnr, map)
      local function goto_parent_dir()
        local parent_dir = vim.fn.fnamemodify(cwd, ":h")
        actions.close(prompt_bufnr)
        require("telescope").extensions.file_browser.file_browser {
          prompt_title = "Select Directory",
          path = parent_dir,
          select_buffer = true,
          hidden = true,
          cwd_to_path = true,
          attach_mappings = function(prompt_bufnr, map)
            local function set_directory_and_grep()
              local selected_entry = action_state.get_selected_entry()
              local dir = selected_entry.path or parent_dir
              actions.close(prompt_bufnr)
              M.live_grep_with_parent_nav(dir)
            end

            local function change_directory()
              local selected_entry = action_state.get_selected_entry()
              if selected_entry and selected_entry.path then
                parent_dir = selected_entry.path
                require("telescope.actions").select_default(prompt_bufnr)
              end
            end

            map("i", "<CR>", set_directory_and_grep)
            map("n", "<CR>", set_directory_and_grep)
            map("i", "<C-p>", fb_actions.goto_parent_dir)
            map("n", "<C-p>", fb_actions.goto_parent_dir)
            map("i", "<C-s>", change_directory)
            map("n", "<C-s>", change_directory)

            return true
          end,
        }
      end

      map("i", "<C-p>", goto_parent_dir)
      map("n", "<C-p>", goto_parent_dir)

      return true
    end,
  }
end

return M
