return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")

			mason_null_ls.setup({
				ensure_installed = {
					"stylua",
					"prettierd",
					"bibtex-tidy",
					"flake8",
				},
				automatic_installation = true,
				handlers = {},
			})

			null_ls.setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(client)
										return client.name == "null-ls" -- tylko null-ls (czyli prettierd, stylua)
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
