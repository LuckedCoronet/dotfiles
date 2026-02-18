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

			-- mini.splitjoin
			require("mini.splitjoin").setup()

			-- mini.surround
			require("mini.surround").setup()

			-- [[ General Workflow ]]

			-- mini.bufremove
			require("mini.bufremove").setup()

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
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Open file explorer" })

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local open_externally = function()
						local entry = MiniFiles.get_fs_entry()
						if not entry then
							return
						end

						local path = entry.path

						-- Special treatment for folders on win32 systems
						if vim.fn.has("win32") == 1 and entry.fs_type == "directory" then
							local win32_path = path:gsub("/", "\\")
							vim.fn.system('explorer.exe "' .. win32_path .. '"')
							return
						end

						vim.ui.open(path)
					end

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
