return {
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = false,
		config = function()
			local mini_icons = require("mini.icons")
			mini_icons.setup()
			mini_icons.mock_nvim_web_devicons()
		end,
	},
	{
		"nvim-mini/mini.nvim",
		version = false,
		lazy = false,
		config = function()
			-- [[ Text Editing ]]

			-- mini.pairs
			require("mini.pairs").setup()

			-- mini.surround
			require("mini.surround").setup()

			-- [[ General Workflow ]]

			-- mini.files
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "L",
					go_out = "h",
					go_out_plus = "H",
					mark_goto = "'",
					mark_set = "m",
					reset = "<BS>",
					reveal_cwd = "<Home>",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
				windows = {
					preview = true,
					width_preview = 30,
				},
			})

			vim.keymap.set("n", "<leader>e", function()
				MiniFiles.open(MiniFiles.get_latest_path())
			end, { desc = "Open file explorer" })

			vim.keymap.set("n", "<leader>E", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Reveal current file in explorer" })

			local function open_externally()
				local entry = MiniFiles.get_fs_entry()
				if not entry or not entry.path then
					return
				end
				
				local _, err = vim.ui.open(entry.path)
				if err then
					vim.notify("Failed to open externally: " .. err, vim.log.levels.ERROR)
				end
			end

			local minifiles_augroup = vim.api.nvim_create_augroup("MiniFilesCustom", { clear = true })
			
			vim.api.nvim_create_autocmd("User", {
				group = minifiles_augroup,
				pattern = "MiniFilesBufferCreate",
				desc = "Sets a keymap to open files/folders externally",
				callback = function(args)
					vim.keymap.set("n", "gx", open_externally, {
						buffer = args.data.buf_id,
						desc = "Open externally",
					})
				end,
			})

			-- mini.sessions
			require("mini.sessions").setup({
				directory = vim.fn.stdpath("data") .. "/sessions",
			})
		end,
	},
}
