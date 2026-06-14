-- Ten plik zawiera autokomendę, która wykrywa konflikty scalania (merge conflicts) w plikach
-- i automatycznie ustawia odpowiedni typ pliku, co pozwala na specjalne podświetlanie składni.

vim.api.nvim_create_autocmd("BufReadPost", {
	-- Tworzy grupę autokomend, aby można było je łatwo zarządzać (np. usuwać).
	group = vim.api.nvim_create_augroup("FiletypeDetector", { clear = true }),

	-- Funkcja zwrotna (callback), która jest wykonywana po wczytaniu bufora.
	callback = function(args)
		-- Pobiera wszystkie linie z bieżącego bufora.
		local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)

		-- Iteruje przez każdą linię w poszukiwaniu znaczników konfliktu scalania.
		for _, line in ipairs(lines) do
			if line:match("^<<<<<<<") or line:match("^=======") or line:match("^>>>>>>>") then
				-- Jeśli znaleziono znacznik, ustawia typ pliku na "git-merge-conflict" dla danego bufora.
				-- Używa `nvim_set_option_value` jako nowoczesnej alternatywy dla deprecated `nvim_buf_set_option`.
				vim.api.nvim_set_option_value("filetype", "git-merge-conflict", { buf = args.buf })
				-- Kończy działanie funkcji po znalezieniu pierwszego dopasowania.
				return
			end
		end
	end,
})

-- Automatyczne przełączanie na SCP-Legacy, gdy w ścieżce jest adres Malinki
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "scp://hestia",
	callback = function()
		vim.g.netrw_scp_cmd = "scp -q -O"
	end,
})
