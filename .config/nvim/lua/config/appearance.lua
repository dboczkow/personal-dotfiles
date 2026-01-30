vim.cmd.colorscheme "catppuccin"

-- Tło kolorów (light/dark)
vim.opt.background = "dark"

-- Typ kolorów w terminalu (24-bit TrueColor)
vim.opt.termguicolors = true

-- Kolumna z sygnałami (np. błędy)
vim.opt.signcolumn = "yes"

-- Numerowanie linii
vim.opt.number = true
vim.opt.relativenumber = true

-- Podświetlenie linii i kolumny kursora
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Pokazywanie niewidocznych znaków (tabulatory, spacje)
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣"
}

-- Pokazywanie aktualnego trybu na statusie
vim.opt.showmode = true

-- Pokazywanie linii zakładek (tabline)
vim.opt.showtabline = 1

-- Formatowanie statusline, minimalistyczny przykład poniżej
require('lualine').setup()

-- Wskaźnik pozycji kursora (linia/kolumna)
vim.opt.ruler = true

-- Składnia zwijania (fold)
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Ustawienia listy poleceń (wildmenu)
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true

-- Znaki wypełnienia (fold, krawędzie itp.)
vim.opt.fillchars = {
  fold = " ",
  vert = "│",
  diff = "╱",
  eob = " ",
  msgsep = "─",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = "│"
}

-- Kolumna koloru do podświetlenia (np. 80 znaków dla linii kodu)

-- Włączenie podświetlenia składni
vim.cmd.syntax("enable")

-- Opcje kursora GUI (przy pracy z GUI)
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Inne wizualne ustawienia do rozważenia:
vim.opt.scrolloff = 8          -- minimalna liczba linii powyżej/poniżej kursora
vim.opt.sidescrolloff = 8      -- minimalna liczba kolumn z lewej/prawej kursora
vim.opt.wrap = false           -- wyłączenie zawijania linii
vim.opt.linebreak = true       -- łamanie linii przy zawijaniu wg. słów

-- ujednolicenie tła popupów z tłem edytora
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "Pmenu",       { link = "Normal" })
vim.api.nvim_set_hl(0, "PmenuSel",    { bg = "#313244" })  -- delikatny highlight

-- blink.cmp własne grupy
vim.api.nvim_set_hl(0, "BlinkCmpMenu",       { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc",        { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder",  { fg = "#89b4fa", bg = "NONE" })

vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = "#89b4fa", bold = true })
