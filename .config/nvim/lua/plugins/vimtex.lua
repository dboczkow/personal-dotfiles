return {
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			-- Ustawienie silnika na LuaLaTeX
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = "-lualatex",
			}

			-- DODAJ TO: Konfiguracja opcji dla latexmk, w tym -shell-escape
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}

			-- Reszta Twojej konfiguracji
			vim.g.vimtex_view_method = "zathura"
		end,
	},
}
