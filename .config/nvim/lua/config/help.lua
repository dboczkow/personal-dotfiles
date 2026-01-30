-- Poprawiona funkcja wyświetlająca podstawowe ruchy Vim
local function show_vim_moves()
  local moves = vim.split([[
Podstawowe ruchy (motions) w trybie normalnym:

Poruszanie kursorem:
• h - lewo    l - prawo
• j - dół     k - góra
• 0 - początek linii    $ - koniec linii
• ^ - pierwszy niepusty znak    g_ - ostatni niepusty
• w - następny słowo    b - poprzedni słowo
• e - koniec słowa      ge - poprzedni koniec słowa

Linie i ekran:
• gg - pierwszy wiersz  G - ostatni wiersz
• {n}G - wiersz n (np. 5G)
• H - górna część ekranu    M - środek    L - dolna
• Ctrl+u - pół ekranu w górę    Ctrl+d - pół w dół
• Ctrl+b - strona w górę    Ctrl+f - strona w dół

Szukanie i znaki:
• f{x} - następny x    F{x} - poprzedni x
• t{x} - przed następnym x    T{x} - przed poprzednim
• ; - powtórz ostatni f/t    , - odwrotnie

Skoki:
• '' - poprzednia pozycja    `` - dokładna poprzednia
• Ctrl+o - starszy skok    Ctrl+i - nowszy skok
  ]], '\n')

  -- Najpierw tworzymy bufor, potem ustawiamy opcje
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, moves)

  -- Ustawiamy opcje PO ustawieniu linii
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = 'help'

  -- Otwieramy w nowym oknie po prawej (split pionowy)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 50,
    height = 30,
    row = 5,
    col = vim.o.columns - 55,
    style = 'minimal',
    border = 'rounded'
  })
end

-- Komenda :VimMoves
vim.api.nvim_create_user_command('VimMoves', show_vim_moves, {})
