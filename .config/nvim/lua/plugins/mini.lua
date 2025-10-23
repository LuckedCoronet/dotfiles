return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup()
		require("mini.bracketed").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()

		require("mini.files").setup({
			windows = {
				preview = true,
				width_preview = 30,
			},
		})
		vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Open file explorer" })
	end,
}
