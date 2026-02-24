vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Options ]]

vim.o.updatetime = 250
vim.o.timeoutlen = 400
vim.o.foldenable = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"
vim.o.undofile = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.schedule(function()
	vim.o.clipboard = "unnamedplus" -- Syncs clipboard with OS
end)

-- [[ Keymaps ]]

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "<leader>p", '"_dP', { silent = true })

-- [[ Autocmds ]]

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ VSCode-specific ]]

if vim.g.vscode then
	local code = require("vscode")

	local function mapCodeAction(mode, key, action)
		vim.keymap.set(mode, key, function()
			code.action(action)
		end, { silent = true, noremap = true })
	end

	mapCodeAction("n", "[c", "workbench.action.editor.previousChange")
	mapCodeAction("n", "]c", "workbench.action.editor.nextChange")
	mapCodeAction("n", "[d", "editor.action.marker.prev")
	mapCodeAction("n", "]d", "editor.action.marker.next")

	-- Workaround for vscode-neovim UI desync (issue #2117)

	local redraw_fix_augroup = vim.api.nvim_create_augroup("VSCodeRedrawFix", { clear = true })

	-- Redraw on CursorHold
	vim.api.nvim_create_autocmd("CursorHold", {
		group = redraw_fix_augroup,
		callback = function()
			vim.cmd("silent! mode")
		end,
	})

	-- Redraw immediately after text changes
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = redraw_fix_augroup,
		callback = function()
			if vim.fn.mode() == "n" then
				vim.cmd("silent! mode")
			end
		end,
	})
end

-- [[ Setup Plugins ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = {
		enabled = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"editorconfig",
				"gzip",
				"man",
				"matchparen",
				"netrwPlugin",
				"osc52",
				"rplugin",
				"spellfile",
				"tarPlugin",
				"tohtml",
				"tohtml",
				"tutor",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
