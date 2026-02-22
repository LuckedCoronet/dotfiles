vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim trailing whitespaces on save",
	group = vim.api.nvim_create_augroup("FallbackWhitespaceTrim", { clear = true }),
	callback = function(args)
		local bufnr = args.buf

		-- Skip unmodifiable or special buffers
		if not vim.bo[bufnr].modifiable then
			return
		end

		-- Check for active LSP formatters
		local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
		if #clients > 0 then
			return
		end

		-- Check for conform.nvim formatters
		local ok, conform = pcall(require, "conform")
		if ok and #conform.list_formatters_to_run(bufnr) > 0 then
			return
		end

		-- Save window view
		local view = vim.fn.winsaveview()

		-- Strip CRLF (^M) if the file format is not Windows/DOS
		if vim.bo[bufnr].fileformat ~= "dos" then
			vim.cmd([[keepjumps keeppatterns %s/\r\+$//e]])
		end

		-- Strip trailing spaces and tabs
		vim.cmd([[keepjumps keeppatterns %s/\s\+$//e]])

		-- Restore window view
		vim.fn.winrestview(view)
	end,
})
