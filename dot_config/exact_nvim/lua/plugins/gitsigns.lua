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
			map("n", "<leader>gs", gitsigns.stage_hunk, "Stage hunk")
			map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")

			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selection")

			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset selection")

			map("n", "<leader>gS", gitsigns.stage_buffer, "Stage buffer")
			map("n", "<leader>gR", gitsigns.reset_buffer, "Reset buffer")
			map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")
			map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview hunk inline")

			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, "Blame line")

			map("n", "<leader>gd", gitsigns.diffthis, "Diff against index")

			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, "Diff against last commit")

			map("n", "<leader>gQ", function()
				gitsigns.setqflist("all")
			end, "All hunks to qflist")

			map("n", "<leader>gq", gitsigns.setqflist, "Hunks to qflist")

			-- Toggles
			map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle line blame")
			map("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle word diff")

			-- Text object
			map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
		end,
	},
	--- @diagnostic enable: missing-fields
}
