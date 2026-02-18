-- [[ UI & Windows ]]

vim.opt.title = true
vim.opt.titlestring = "nvim" -- Set the process title strictly to "nvim"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split" -- Live preview of substitute commands

-- [[ Formatting & Visuals ]]

vim.opt.expandtab = false -- Use tab characters for indent (by default)
vim.opt.tabstop = 4 -- A tab character looks like 4 spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.breakindent = true -- Preserve indentation for wrapped lines
vim.opt.list = true -- Show invisible characters
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

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
