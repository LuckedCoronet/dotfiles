return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {
		files = {
			cwd_prompt = false,
			git_icons = true,
			formatter = "path.filename_first",
		},
		grep = {
			cwd_prompt = false,
			git_icons = true,
			rg_opts = [[--column --line-number --no-heading --color=always --hidden --smart-case --max-columns=150 -g "!.git" -g "!node_modules" -e]],
		},
		fzf_colors = true,
	},
	---@diagnostic enable: missing-fields
	keys = {
		{ "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Search files" },
		{ "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "Search open buffers" },
		{ "<leader>so", "<cmd>FzfLua oldfiles<cr>", desc = "Search oldfiles" },
		{ "<leader>sl", "<cmd>FzfLua live_grep<cr>", desc = "Search grep live" },
		{ "<leader>su", "<cmd>FzfLua undotree<cr>", desc = "Search undo tree" },
		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Search jumps" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Search help tags" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search keymaps" },
		{ "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "Search resume" },
		{ "<leader>sgf", "<cmd>FzfLua git_files<cr>", desc = "Search Git files" },
		{ "<leader>sgs", "<cmd>FzfLua git_status<cr>", desc = "Search Git status" },
		{ "<leader>sgd", "<cmd>FzfLua git_diff<cr>", desc = "Search Git diff" },
		{ "<leader>sgh", "<cmd>FzfLua git_hunks<cr>", desc = "Search Git hunks" },
		{ "<leader>sgc", "<cmd>FzfLua git_bcommits<cr>", desc = "Search Git commits (buffer)" },
		{ "<leader>sgC", "<cmd>FzfLua git_commits<cr>", desc = "Search Git commits (project)" },
		{ "<leader>sgb", "<cmd>FzfLua git_blame<cr>", desc = "Search Git blame" },
		{ "<leader>sgr", "<cmd>FzfLua git_branches<cr>", desc = "Search Git branches" },
	},
}
