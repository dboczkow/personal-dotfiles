-- Ten plik zarządza instalacją i konfiguracją menedżera pluginów `lazy.nvim`.

-- Ścieżka do instalacji lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Sprawdza, czy lazy.nvim jest już zainstalowany.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	-- Jeśli nie, klonuje repozytorium lazy.nvim z GitHub.
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	-- Używa `--filter=blob:none` i `--branch=stable` dla szybszego klonowania.
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	-- Sprawdza, czy klonowanie się powiodło.
	if vim.v.shell_error ~= 0 then
		-- Jeśli wystąpił błąd, wyświetla komunikat i kończy działanie Neovim.
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Dodaje ścieżkę do lazy.nvim do `runtimepath`, aby Neovim mógł go załadować.
vim.opt.rtp:prepend(lazypath)

-- Ważne jest, aby ustawić `mapleader` i `maplocalleader` PRZED załadowaniem lazy.nvim.
-- Dzięki temu wszystkie mapowania klawiszy zdefiniowane przez pluginy będą używać poprawnego lidera.
vim.g.mapleader = " " -- Globalny lider, najczęściej spacja.
vim.g.maplocalleader = "\\" -- Lokalny lider dla mapowań specyficznych dla bufora.

-- Konfiguracja i uruchomienie lazy.nvim.
require("lazy").setup({
	-- `spec` definiuje, skąd ładować specyfikacje pluginów.
	spec = {
		-- Importuje wszystkie pluginy z pliku `lua/plugins/init.lua` (lub `lua/plugins.lua`).
		{ import = "plugins" },
	},
	-- Dodatkowe opcje konfiguracyjne dla lazy.nvim.
	install = {
		-- Ustawia schemat kolorów używany podczas instalacji pluginów.
		colorscheme = { "catppuccin" },
	},
	-- Włącza automatyczne sprawdzanie dostępności aktualizacji pluginów.
	checker = { enabled = true },
	ui = {
		border = "rounded",
	},
})
