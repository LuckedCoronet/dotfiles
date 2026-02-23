return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {
					"icon",
				},
				delete_to_trash = true,
				watch_for_changes = true,
				win_options = {
					signcolumn = "yes:2",
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, bufnr)
						local m = name:match("^%.git$")
						return m ~= nil
					end,
					case_insensitive = true,
				},
			})

			vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })
		end,
	},
	{
		"refractalize/oil-git-status.nvim",
		event = "VeryLazy",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
