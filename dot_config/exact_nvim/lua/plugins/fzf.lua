return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	config = function()
		require("fzf-lua").setup({
			files = {
				cwd_prompt = false,
				git_icons = true,
			},
			grep = {
				cwd_prompt = false,
				hidden = true,
			},
		})

		vim.keymap.set("n", "<leader>f", FzfLua.global, { desc = "Search global" })
		vim.keymap.set("n", "<leader><leader>", FzfLua.buffers, { desc = "Search open buffers" })
		vim.keymap.set("n", "<leader>sf", FzfLua.files, { desc = "Search files" })
		vim.keymap.set("n", "<leader>so", FzfLua.files, { desc = "Search oldfiles" })
		vim.keymap.set("n", "<leader>sg", FzfLua.grep, { desc = "Search grep" })
		vim.keymap.set("n", "<leader>sl", FzfLua.live_grep, { desc = "Search grep live" })
		vim.keymap.set("n", "<leader>su", FzfLua.undotree, { desc = "Search undo tree" })
		vim.keymap.set("n", "<leader>sj", FzfLua.jumps, { desc = "Search jumps" })
		vim.keymap.set("n", "<leader>sh", FzfLua.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>sk", FzfLua.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>sr", FzfLua.resume, { desc = "Search resume" })
	end,
}
