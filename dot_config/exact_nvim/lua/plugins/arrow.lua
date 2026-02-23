return {
	"otavioschwanck/arrow.nvim",
	keys = { "-", "m" },
	opts = {
		show_icons = true,
		save_path = function()
			return vim.fn.stdpath("data") .. "/arrow"
		end,
		leader_key = "-",
		buffer_leader_key = "m",
	}
}
