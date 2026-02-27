-- Ten plik konfiguruje zachowanie Language Server Protocol (LSP) w Neovim.
-- LSP dostarcza funkcji takich jak autouzupełnianie, diagnostyka, nawigacja po kodzie itp.

-- Włącza konkretne serwery językowe.
-- "lua_ls" to serwer dla języka Lua.
-- "vtsls" (Vue TypeScript Language Server) to serwer dla projektów Vue i TypeScript/JavaScript.
vim.lsp.enable({ "lua_ls", "vtsls" })

-- Konfiguracja globalnych ustawień diagnostyki LSP.
vim.diagnostic.config({
	-- Wyświetla diagnostykę jako wirtualny tekst na końcu linii.
	virtual_text = true,

	-- Podkreśla tekst, w którym występuje błąd/ostrzeżenie.
	underline = true,

	-- Aktualizuje diagnostykę w trybie wstawiania (Insert Mode).
	update_in_insert = true,

	-- Sortuje diagnostykę według poziomu ważności (severity).
	severity_sort = true,

	-- Konfiguracja "pływającego" okna, które pojawia się po najechaniu na diagnostykę.
	float = {
		border = "rounded", -- Ustawia zaokrąglone ramki dla okna.
		source = true, -- Pokazuje źródło diagnostyki (np. "eslint", "typescript").
	},

	-- Konfiguracja ikon wyświetlanych w kolumnie `signcolumn` dla różnych poziomów diagnostyki.
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ", -- Ikona dla błędów.
			[vim.diagnostic.severity.WARN] = "󰀪 ", -- Ikona dla ostrzeżeń.
			[vim.diagnostic.severity.INFO] = "󰋽 ", -- Ikona dla informacji.
			[vim.diagnostic.severity.HINT] = "󰌶 ", -- Ikona dla podpowiedzi.
		},
		-- Podświetla numer linii, w której występuje błąd lub ostrzeżenie.
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
