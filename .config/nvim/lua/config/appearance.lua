-- Ten plik odpowiada za wygląd edytora Neovim.

-- Ustawienie schematu kolorów. "catppuccin" to popularny schemat kolorów.
vim.cmd.colorscheme("catppuccin")

-- Określa, czy tło jest jasne, czy ciemne. Ma to wpływ na to, jak schemat kolorów jest ładowany.
vim.opt.background = "dark"

-- Włącza wsparcie dla 24-bitowych kolorów (TrueColor) w terminalu.
-- Wymaga to kompatybilnego emulatora terminala.
vim.opt.termguicolors = true

-- Kolumna po lewej stronie, która wyświetla znaki diagnostyczne, punkty przerwania itp.
vim.opt.signcolumn = "yes"

-- Numerowanie linii.
vim.opt.number = true -- Pokazuje numery linii.
vim.opt.relativenumber = true -- Pokazuje numery linii relatywnie do pozycji kursora.

-- Podświetlenie bieżącej linii i kolumny.
vim.opt.cursorline = true -- Podświetla linię, w której znajduje się kursor.
vim.opt.cursorcolumn = false -- Wyłącza podświetlanie kolumny kursora dla lepszej wydajności.

-- Konfiguracja wyświetlania niewidocznych znaków.
vim.opt.list = true -- Włącza pokazywanie niewidocznych znaków.
vim.opt.listchars = {
	tab = "┊ ", -- Znak dla tabulacji.
	trail = "·", -- Znak dla spacji na końcu linii.
	extends = "»", -- Znak wskazujący, że linia jest dłuższa niż ekran.
	precedes = "«", -- Znak wskazujący, że linia zaczyna się przed ekranem.
	nbsp = "␣", -- Znak dla twardej spacji.
}

-- Pokazuje aktualny tryb (np. INSERT, NORMAL) w wierszu poleceń.
vim.opt.showmode = true

-- Określa, kiedy pokazywać pasek z zakładkami (tabline).
-- 0: nigdy, 1: tylko jeśli jest więcej niż jedna zakładka, 2: zawsze.
vim.opt.showtabline = 1

-- Inicjalizacja paska statusu Lualine. Konfiguracja znajduje się w jego własnym pliku.
require("lualine").setup()

-- Pokazuje pozycję kursora (linia i kolumna) w prawym dolnym rogu.
vim.opt.ruler = true

-- Konfiguracja zwijania kodu (folding).
vim.opt.foldmethod = "indent" -- Zwija kod na podstawie wcięć.
vim.opt.foldlevel = 99 -- Domyślnie rozwija wszystkie zwinięcia.
vim.opt.foldenable = true -- Włącza zwijanie kodu.

-- Definiuje znaki używane do wypełniania różnych elementów interfejsu.
vim.opt.fillchars = {
	fold = " ",
	vert = "│",
	diff = "╱",
	eob = " ", -- End-of-buffer
	msgsep = "─",
	foldopen = "", -- Ikona dla otwartego zwinięcia.
	foldclose = "", -- Ikona dla zamkniętego zwinięcia.
	foldsep = "│",
}

-- Włącza podświetlanie składni.
vim.cmd.syntax("enable")

-- Definiuje minimalną liczbę linii widocznych powyżej i poniżej kursora podczas przewijania.
vim.opt.scrolloff = 8
-- Definiuje minimalną liczbę kolumn widocznych po lewej i prawej stronie kursora.
vim.opt.sidescrolloff = 16

-- Kontrola zawijania linii.
vim.opt.wrap = false -- Wyłącza automatyczne zawijanie długich linii.
vim.opt.linebreak = true -- Jeśli zawijanie jest włączone, łamie linie na granicach słów.

-- Ujednolicenie tła dla okien "pływających" (np. podpowiedzi LSP) z tłem edytora.
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
-- Ujednolicenie tła dla menu uzupełniania.
vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#313244" }) -- Delikatne podświetlenie wybranej pozycji.

-- Własne grupy podświetlenia dla pluginu `blink.cmp`.
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "NONE" })

-- Ustawienie koloru dla symboli wcięcia z pluginu `mini.indentscope`.
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#89b4fa", bold = true })

-- Ustawienia kolor dla podświetlenia wyszukiwania oraz kopiowania
vim.api.nvim_set_hl(0, "IncSearch", {
	bg = "#cba6f7",
	fg = "#1e1e2e",
})

-- Konfiguracja podświetlenia dla podpowiedzi wbudowanych (inlay hints) od LSP.
-- Łączy styl z grupą 'NonText', aby były mniej nachalne.
vim.api.nvim_set_hl(0, "LspInlayHint", {
	link = "NonText",
})
-- Dalsze dostosowanie podpowiedzi: kolor jak komentarz, bez tła, kursywa.
vim.api.nvim_set_hl(0, "LspInlayHint", {
	-- fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg,
	fg = "#45475a",
	bg = "NONE",
	italic = true,
})
