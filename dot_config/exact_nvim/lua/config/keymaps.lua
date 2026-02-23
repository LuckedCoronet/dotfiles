local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights", silent = true })
map({ "n", "x" }, "<leader>p", '"_dP', { desc = "Paste without copying", silent = true })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics window" })

-- Exit to normal mode
map("i", "fj", "<Esc>", { desc = "Exit insert mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation focus
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper window" })

-- Moving windows
map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
map("n", "<C-S-j>", "<C-w>J", { desc = "Move window down" })
map("n", "<C-S-k>", "<C-w>K", { desc = "Move window up" })

-- Window resizing
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize width -" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize width +" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Resize height +" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Resize height -" })
