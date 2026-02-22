-- [[ UI & Windows ]]

vim.opt.title = true
vim.opt.titlestring = "nvim"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

-- [[ Formatting & Visuals ]]

-- Use physical tabs instead of spaces
vim.opt.expandtab = false

-- Set tab width and indentation size to 4 columns
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

-- [[ System & Behavior ]]

vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.confirm = true

-- Enable persistent undo
local undo_path = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_path) == 0 then
	vim.fn.mkdir(undo_path, "p")
end
vim.opt.undodir = undo_path
vim.opt.undofile = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
