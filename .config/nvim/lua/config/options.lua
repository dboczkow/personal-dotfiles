-- Plik ten zawiera główne opcje konfiguracyjne dla Neovim.
-- Opcje są podzielone na kategorie dla lepszej czytelności.

-- Indentacja
vim.opt.autoindent = true -- Automatyczne wcięcia, które kopiują wcięcia z poprzedniej linii.
vim.opt.smartindent = true -- Inteligentne wcięcia, które reagują na składnię języka.
vim.opt.cindent = false -- Wyłącza wcięcia w stylu C, `smartindent` jest preferowany.
vim.opt.shiftwidth = 2 -- Liczba spacji używana do wcięć (np. dla operacji >>, <<).
vim.opt.softtabstop = 2 -- Liczba spacji, którą wstawia klawisz Tab w trybie wstawiania.
vim.opt.tabstop = 2 -- Liczba spacji, na jaką jest renderowana tabulacja.
vim.opt.expandtab = true -- Używaj spacji zamiast tabulacji.

-- Zarządzanie plikami
vim.opt.autoread = true -- Automatycznie wczytuj plik, jeśli został zmieniony na zewnątrz Neovim.
vim.opt.autowrite = true -- Automatycznie zapisuj plik przy niektórych komendach (np. :next).
vim.opt.swapfile = false -- Wyłącza pliki wymiany (.swp).
vim.opt.backup = false -- Wyłącza tworzenie plików zapasowych.
vim.opt.undofile = true -- Włącza trwałą historię cofania (undo).
vim.opt.undodir = os.getenv("HOME") .. "/.cache/vim/history" -- Katalog do przechowywania plików historii cofania.
vim.opt.encoding = "utf-8" -- Ustawia domyślne kodowanie plików na UTF-8.

-- Wyszukiwanie
vim.opt.ignorecase = true -- Ignoruj wielkość liter podczas wyszukiwania.
vim.opt.smartcase = true -- Jeśli wzorzec wyszukiwania zawiera wielkie litery, wyszukiwanie staje się wrażliwe na wielkość liter.
vim.opt.hlsearch = false -- Nie podświetlaj wszystkich wyników wyszukiwania na stałe.
vim.opt.incsearch = true -- Podświetlaj wyniki wyszukiwania na bieżąco podczas wpisywania.
vim.opt.inccommand = "nosplit"

-- Wiersz poleceń
vim.opt.cmdheight = 1 -- Wysokość wiersza poleceń (w liniach).
vim.opt.updatetime = 300 -- Czas w milisekundach, po którym Neovim zapisuje zawartość bufora na dysk (ważne dla pluginów, które reagują na bezczynność).
vim.opt.timeoutlen = 500 -- Czas w milisekundach na oczekiwanie na dokończenie sekwencji mapowania.
vim.opt.ttimeoutlen = 10 -- Czas w milisekundach na oczekiwanie na kody klawiszy terminala.

-- Terminal
vim.o.shell = "/usr/bin/zsh" -- Ustawia domyślną powłokę.

-- Historia i uzupełnianie
vim.opt.history = 1000 -- Liczba poleceń przechowywanych w historii.
vim.opt.wildmenu = true -- Włącza menu uzupełniania dla poleceń w wierszu poleceń.
vim.opt.wildmode = { "longest", "list", "full" } -- Definiuje zachowanie uzupełniania w wierszu poleceń.

-- Wsparcie dla myszy
vim.opt.mouse = "a" -- Włącza wsparcie dla myszy we wszystkich trybach.

-- Schowek
vim.opt.clipboard = "unnamedplus" -- Używaj systemowego schowka (rejestr '+') domyślnie dla operacji kopiowania/wklejania.

-- Podświetlanie skopiowanego tekstu
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Podświetla skopiowany tekst po operacji yank.",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})

-- Opcje buforów i okien
vim.opt.hidden = true -- Pozwala na ukrywanie buforów bez zapisywania zmian.
vim.opt.splitright = true -- Otwieraj nowe okna po prawej stronie.
vim.opt.splitbelow = true -- Otwieraj nowe okna poniżej.
vim.opt.equalalways = false -- Nie zmieniaj rozmiaru okien automatycznie po ich otwarciu/zamknięciu.

-- Różne
vim.opt.errorbells = false -- Wyłącza dźwięk błędu.
vim.opt.belloff = "all" -- Wyłącza wszystkie dzwonki.
vim.opt.spell = true -- Włącza sprawdzanie pisowni.
vim.opt.spelllang = "en_us,pl" -- Ustawia języki do sprawdzania pisowni.

-- Opcje uzupełniania
vim.opt.completeopt = { "menuone", "noselect", "noinsert" } -- Konfiguruje zachowanie menu uzupełniania.

-- Wykrywanie formatu pliku
vim.opt.fileformats = { "unix", "dos", "mac" } -- Kolejność formatów końca linii do sprawdzenia.
