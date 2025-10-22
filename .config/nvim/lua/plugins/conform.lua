local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>f',
			function()
				require('conform').format { async = true, lsp_format = 'fallback' }
			end,
			mode = '',
			desc = 'Format Document',
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = {
				c = true,
				cpp = true,
			}
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = 'fallback',
				}
			end
		end,
		formatters_by_ft = {
			lua = { 'stylua' },
			javascript = prettier,
			typescript = prettier,
			json = prettier,
			jsonc = prettier,
			json5 = prettier,
		},
	},
}
