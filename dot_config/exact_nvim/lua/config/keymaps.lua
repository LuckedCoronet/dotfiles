local map = vim.keymap.set

-- "Void" paste (paste without copying the overwritten text)
map({ "n", "x" }, "<leader>p", '"_dP', { desc = "Paste without copying", silent = true })

-- Clear Search Highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights", silent = true })

-- Better Exit Modes
map("i", "fj", "<Esc>", { desc = "Exit insert mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window Navigation Focus
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper window" })

-- Moving Windows
map("n", "<leader>h", "<C-w>H", { desc = "Move window to the left" })
map("n", "<leader>l", "<C-w>L", { desc = "Move window to the right" })
map("n", "<leader>j", "<C-w>J", { desc = "Move window down" })
map("n", "<leader>k", "<C-w>K", { desc = "Move window up" })

-- Window Resizing
map("n", "<M-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize width -" })
map("n", "<M-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize width +" })
map("n", "<M-Up>", "<cmd>resize +2<CR>", { desc = "Resize height +" })
map("n", "<M-Down>", "<cmd>resize -2<CR>", { desc = "Resize height -" })

-- Reveal current file in system explorer
vim.keymap.set("n", "<leader>x", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file buffer is open", vim.log.levels.WARN)
		return
	end

	local cmd = ""
	if vim.fn.has("win32") == 1 then
		cmd = 'explorer.exe /select,"' .. path .. '"'
	elseif vim.fn.has("mac") == 1 then
		cmd = 'open -R "' .. path .. '"'
	else
		local dir = vim.fn.expand("%:p:h")
		cmd = 'xdg-open "' .. dir .. '"'
	end

	-- Execute the command silently
	os.execute(cmd)
end, { desc = "Reveal in system explorer" })
