return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		preset = "helix",
		delay = 300, -- this setting is independent of vim.o.timeoutlen
		icons = {
			mappings = true,
			keys = {},
		},
	},
}
