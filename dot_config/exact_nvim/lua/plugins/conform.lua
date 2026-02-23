local js_formatters = { "biome", "prettier", stop_after_first = true }

local formatters_by_ft = {
	lua = { "stylua" },
}

local web_filetypes = {
	-- JavaScript / TypeScript
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",

	-- Frameworks & Templates
	"vue",
	"svelte",
	"astro",
	"handlebars",

	-- Styling
	"css",
	"scss",
	"less",

	-- Markup & Documentation
	"html",
	"markdown",
	"markdown.mdx",
	"mdx",

	-- Data & Configuration
	"json",
	"jsonc",
	"json5",
	"yaml",
	"graphql",
}

for _, ft in ipairs(web_filetypes) do
	formatters_by_ft[ft] = js_formatters
end

local ignore_patterns = {
	"%.git/",
	"/node_modules/",
}

local should_ignore = function(path)
	local normalized_path = path:gsub("\\", "/")
	for _, pattern in ipairs(ignore_patterns) do
		if string.find(normalized_path, pattern) then
			return true
		end
	end
	return false
end

return {
	"stevearc/conform.nvim",
	event = { "VeryLazy" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				if should_ignore(vim.api.nvim_buf_get_name(bufnr)) then
					return
				end

				return { timeout_ms = 1000, lsp_format = "fallback" }
			end,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local bufnr = vim.api.nvim_get_current_buf()

			if not vim.bo[bufnr].modifiable then
				return
			end

			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end

			conform.format({ async = true, range = range })
		end, { range = true })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, { desc = "Disable format on save", bang = true })

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, { desc = "Re-enable format on save" })
	end,
}
