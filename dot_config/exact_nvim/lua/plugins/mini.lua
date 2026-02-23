return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	priority = 100,
	config = function()
		local mini_icons = require("mini.icons")
		mini_icons.setup()
		mini_icons.mock_nvim_web_devicons()

		require("mini.pairs").setup()

		require("mini.surround").setup()
	end,
}
