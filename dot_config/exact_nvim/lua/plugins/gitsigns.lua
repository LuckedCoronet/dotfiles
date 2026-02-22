return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	--- @module "gitsigns"
	--- @type Gitsigns.Config
	--- @diagnostic disable: missing-fields
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, desc)
				local opts = {
					buffer = bufnr,
					desc = desc,
				}
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, "Next hunk")

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, "Previous hunk")

			-- Actions
			map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")

			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selection")

			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset selection")

			map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
			map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
			map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")

			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, "Blame line full")

			map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")

			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, "Diff against last commit")

			map("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, "All hunks to qflist")

			map("n", "<leader>hq", gitsigns.setqflist, "Hunks to qflist")

			-- Toggles
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle line blame")
			map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word diff")

			-- Text object
			map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
		end,
	},
	--- @diagnostic enable: missing-fields
}
