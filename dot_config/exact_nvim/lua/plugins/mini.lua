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

		local mini_pick = require("mini.pick")

		local function get_item_text(item)
			if type(item) == "table" then
				return item.text or item.path or tostring(item)
			end
			return type(item) == "string" and item or tostring(item)
		end

		local custom_picker_show = function(buf_id, items_to_show)
			local lines = {}
			local extmarks = {}
			local ns_id = vim.api.nvim_create_namespace("MiniPickCustomShow")

			local matches = mini_pick.get_picker_matches()
			local current_item = matches and matches.current
			local marked_items = matches and matches.marked or {}

			for i, item in ipairs(items_to_show) do
				local row = i - 1
				local text = get_item_text(item)
				local line_str = text

				if type(item) == "table" or type(item) == "string" then
					local tail = vim.fn.fnamemodify(text, ":t")
					local dir = vim.fn.fnamemodify(text, ":h")
					local display_dir = (dir == "." or dir == "") and "" or ("  " .. dir)

					local icon, icon_hl = mini_icons.get("file", tail)
					local icon_str = icon and (icon .. " ") or ""

					line_str = icon_str .. tail .. display_dir

					local current_col = 0

					if icon_str ~= "" and icon_hl then
						table.insert(extmarks, {
							line = row,
							col = current_col,
							end_col = #icon_str,
							hl_group = icon_hl,
							priority = 10,
						})
					end

					current_col = #icon_str + #tail

					if display_dir ~= "" then
						table.insert(extmarks, {
							line = row,
							col = current_col,
							end_col = #line_str,
							hl_group = "Comment",
							priority = 10,
						})
					end
				end

				table.insert(lines, line_str)

				if item == current_item then
					table.insert(extmarks, {
						line = row,
						col = 0,
						end_col = #line_str,
						hl_group = "MiniPickMatchCurrent",
						priority = 1,
						hl_eol = true,
					})
				end

				if vim.tbl_contains(marked_items, item) then
					table.insert(extmarks, {
						line = row,
						col = 0,
						end_col = #line_str,
						hl_group = "MiniPickMatchMarked",
						priority = 2,
					})
				end
			end

			vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
			vim.api.nvim_buf_clear_namespace(buf_id, ns_id, 0, -1)

			for _, em in ipairs(extmarks) do
				vim.api.nvim_buf_set_extmark(buf_id, ns_id, em.line, em.col, {
					end_col = em.end_col,
					hl_group = em.hl_group,
					hl_eol = em.hl_eol,
					priority = em.priority,
				})
			end
		end

		mini_pick.setup({
			options = {
				use_cache = true,
			},
			window = {
				config = function()
					local lines, columns = vim.o.lines, vim.o.columns
					local height = math.floor(0.4 * lines)
					local width = math.floor(0.6 * columns)

					return {
						anchor = "NW",
						height = height,
						width = width,
						row = math.floor(0.5 * (lines - height)),
						col = math.floor(0.5 * (columns - width)),
					}
				end,
			},
		})

		vim.keymap.set("n", "<leader>sf", function()
			MiniPick.builtin.files({}, {
				source = { show = custom_picker_show },
			})
		end, { desc = "Search files" })

		vim.keymap.set("n", "<leader>sl", MiniPick.builtin.grep_live, { desc = "Search grep live" })
		vim.keymap.set("n", "<leader>sh", MiniPick.builtin.help, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>sb", MiniPick.builtin.buffers, { desc = "Search buffers" })
		vim.keymap.set("n", "<leader>sr", MiniPick.builtin.resume, { desc = "Search resume" })
	end,
}
