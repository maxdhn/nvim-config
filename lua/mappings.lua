require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- GotoTab
for i = 1, 9 do
  vim.keymap.set("n", string.format("<A-%d>", i), function()
    vim.cmd("tabnext " .. i)
  end, { desc = string.format("Go to tab %d", i) })
end
-- TEST
map(
  "n",
  "<leader>tt",
  ':lua require("custom.test").toggle_source_test()<CR>',
  { noremap = true, silent = true, desc = "Toggle between source and test file" }
)

-- TELESCOPE
vim.api.nvim_del_keymap("n", "<leader>fa")
vim.api.nvim_del_keymap("n", "<leader>fh")
map(
  "n",
  "<leader>fF",
  ":Telescope find_files hidden=true<CR>",
  { desc = "Find files (include hidden files)", noremap = true, silent = true }
)
map(
  "n",
  "<leader>fW",
  ":Telescope live_grep hidden=true<CR>",
  { desc = "Live Grep (include hidden files)", noremap = true, silent = true }
)

-- BUFFER
vim.api.nvim_del_keymap("n", "<leader>b")
map(
  "n",
  "<leader>bc",
  ':lua require("nvchad.tabufline").closeAllBufs(false)<CR>',
  { desc = "Close all buffers except the current", noremap = true, silent = true }
)
map(
  "n",
  "<leader>bl",
  ':lua require("nvchad.tabufline").closeBufs_at_direction("left")<CR>',
  { desc = "Close all buffers to the left", noremap = true, silent = true }
)
map(
  "n",
  "<leader>br",
  ':lua require("nvchad.tabufline").closeBufs_at_direction("right")<CR>',
  { desc = "Close all buffers to the right", noremap = true, silent = true }
)
map("n", "<leader>bh", ":split<CR>", { desc = "Horizontal Split", noremap = true, silent = true })
map("n", "<leader>bv", ":vsplit<CR>", { desc = "Vertical Split", noremap = true, silent = true })
map("n", "<leader>q", ":close<CR>", { desc = "Close Split", noremap = true, silent = true })
map("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Resize Up" })
map("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Resize Down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Resize Left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Resize Right" })
map("i", "<C-s>", "<ESC>:w<CR>a", { noremap = true, silent = true })
