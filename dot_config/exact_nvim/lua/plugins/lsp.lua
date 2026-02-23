return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local lsp_augroup = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

		---@param client vim.lsp.Client
		---@param bufnr integer
		local setup_document_highlight = function(client, bufnr)
			if not client:supports_method("textDocument/documentHighlight", bufnr) then
				return
			end

			local cursor_hold_augroup = vim.api.nvim_create_augroup("LspCursorHold", { clear = false })

			-- Trigger highlight on hold
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = cursor_hold_augroup,
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})

			-- Clear highlight on move
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = cursor_hold_augroup,
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})

			-- Clean up highlights when the LSP detaches
			vim.api.nvim_create_autocmd("LspDetach", {
				group = cursor_hold_augroup,
				buffer = bufnr,
				callback = function(event)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = cursor_hold_augroup, buffer = event.buf })
				end,
			})
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_augroup,
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local bufnr = event.buf

				if not client then
					return
				end

				setup_document_highlight(client, bufnr)
			end,
		})

		-- Configure language servers

		local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", {
			capabilities = cmp_capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						pathStrict = false, -- Disable strict path checking so lazydev can inject types
					},
				},
			},
		})

		-- Enable language servers

		require("mason-lspconfig").setup({
			automatic_enable = true, -- Enable all language servers installed via mason
		})
	end,
}
