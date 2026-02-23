return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"mason-org/mason.nvim",
			build = ":MasonUpdate",
			opts = {},
		},
	},
	opts = {
		ensure_installed = {
			"lua-language-server",
			"stylua",
		},
		auto_update = false,
		run_on_start = true,
	},
}
