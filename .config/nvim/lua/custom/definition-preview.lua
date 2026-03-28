local function preview_definition()
	local client = vim.lsp.get_clients({ bufnr = 0 })[1]
	if not client then
		print("LSP nie jest aktywne")
		return
	end

	-- Konfiguracja wyglądu - zmieniaj tutaj
	local config = {
		width = 0.7,
		height = 0.4,
		border = "rounded",
		title = "  Definition ",
		title_pos = "center",
	}

	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

	vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, ctx, _)
		if result == nil or vim.tbl_isempty(result) then
			print("Nie znaleziono definicji")
			return
		end

		local res = vim.islist(result) and result[1] or result
		local uri = res.uri or res.targetUri
		local range = res.range or res.targetSelectionRange

		local bufnr = vim.uri_to_bufnr(uri)
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			vim.fn.bufload(bufnr)
		end

		local win_opts = {
			relative = "cursor",
			width = math.floor(vim.o.columns * config.width),
			height = math.floor(vim.o.lines * config.height),
			row = 1,
			col = 0,
			style = "minimal",
			border = config.border,
			title = config.title,
			title_pos = config.title_pos,
			focusable = true,
		}

		local winid = vim.api.nvim_open_win(bufnr, true, win_opts)
		vim.api.nvim_win_set_cursor(winid, { range.start.line + 1, range.start.character })

		local filename = vim.uri_to_fname(uri)
		local ft = vim.filetype.match({ filename = filename })
		if ft then
			vim.bo[bufnr].filetype = ft
		end

		local opts = { buffer = bufnr, silent = true }

		-- Zamknięcie okna
		vim.keymap.set("n", "q", "<cmd>close<cr>", opts)
		vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", opts)

		-- ENTER: Skok do definicji (zamyka podgląd i otwiera plik w oknie pod spodem)
		vim.keymap.set("n", "<CR>", function()
			vim.api.nvim_win_close(winid, true)
			vim.lsp.buf.definition()
		end, opts)
	end)
end

-- Komenda i skrót
vim.api.nvim_create_user_command("PreviewDefinition", preview_definition, {})
