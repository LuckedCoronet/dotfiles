return {
	"saghen/blink.cmp",
	event = { "VeryLazy" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
	},
	version = "1.*",
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		appearance = {
			nerd_font_variant = "normal",
		},
		completion = { documentation = { auto_show = false } },
		fuzzy = { implementation = "prefer_rust" },
		keymap = {
			preset = "super-tab",
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		signature = {
			enabled = true,
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
