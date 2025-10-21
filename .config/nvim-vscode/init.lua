vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.undofile = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = 'split'

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", "<cmd>normal! J<cr>", { silent = true })
vim.keymap.set({ "n", "x" }, "<leader>p", '"_dP', { silent = true })

if vim.g.vscode then
	local code = require("vscode")

	-- `J` to scroll multiple lines down
	vim.keymap.set("n", "J", function()
		local count = vim.v.count1 == 1 and 5 or vim.v.count1
		code.call("cursorMove", { args = { to = "down", by = "wrappedLine", value = count } })
	end, { silent = true })

	-- `K` to scroll multiple lines up
	vim.keymap.set("n", "K", function()
		local count = vim.v.count1 == 1 and 5 or vim.v.count1
		code.call("cursorMove", { args = { to = "up", by = "wrappedLine", value = count } })
	end, { silent = true })

	local function mapCodeAction(mode, key, action)
		vim.keymap.set(mode, key, function()
			code.action(action)
		end, { silent = true, noremap = true })
	end

	mapCodeAction("n", "<leader>k", "editor.action.showHover")
	mapCodeAction("n", "H", "workbench.action.previousEditor")
	mapCodeAction("n", "L", "workbench.action.nextEditor")
	mapCodeAction("n", "[h", "workbench.action.editor.previousChange")
	mapCodeAction("n", "]h", "workbench.action.editor.nextChange")
	mapCodeAction("n", "[d", "editor.action.marker.prev")
	mapCodeAction("n", "]d", "editor.action.marker.next")

	-- Workaround for vscode-neovim UI desync (issue #2117)

  -- 1. Redraw on CursorHold (idle for some time)
  local redraw_fix = vim.api.nvim_create_augroup('VSCodeRedrawFix', { clear = true })
  vim.api.nvim_create_autocmd('CursorHold', {
    group = redraw_fix,
    callback = function()
      vim.cmd('silent! mode')  -- triggers a lightweight redraw
    end,
  })

  -- 2. Redraw immediately after text changes (e.g., visual delete)
  local redraw_group = vim.api.nvim_create_augroup('RedrawOnDelete', { clear = true })
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = redraw_group,
    callback = function()
      if vim.fn.mode() == 'n' then
        vim.cmd('silent! mode')  -- refresh UI after delete/insert
      end
    end,
  })
end

-- Setup lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Setup plugins
require('lazy').setup({
	{
		'echasnovski/mini.ai',
		opts = {
			n_lines = 500,
		},
	},

	{
		'echasnovski/mini.surround',
		opts = {},
	},
})
