---@brief
---
--- https://github.com/ltex-plus/ltex-ls-plus
---
--- LTeX Language Server: LSP language server for LanguageTool 🔍✔️ with support for LaTeX 🎓, Markdown 📝, and others
---
--- To install, download the latest [release](https://github.com/ltex-plus/ltex-ls-plus) and ensure `ltex-ls-plus` is on your path.
---
--- This server accepts configuration via the `settings` key.
---
--- ```lua
---   settings = {
---     ltex = {
---       language = "en-GB",
---     },
---   },
--- ```
---
--- To support org files or R sweave, users can define a custom filetype autocommand (or use a plugin which defines these filetypes):
---
--- ```lua
--- vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]
--- ```

local language_id_mapping = {
	bib = "bibtex",
	pandoc = "markdown",
	plaintex = "tex",
	rnoweb = "rsweave",
	rst = "restructuredtext",
	tex = "latex",
	text = "plaintext",
}

local on_attach = function(client, bufnr)
	-- To pozwala ltex-utils przejąć obsługę komend dodawania do słownika
	require("ltex-utils").on_attach(client, bufnr)
end

---@type vim.lsp.Config
return {
	cmd = { "ltex-ls-plus" },
	on_attach = on_attach,
	filetypes = {
		"asciidoc",
		"bib",
		"context",
		"gitcommit",
		"html",
		"markdown",
		"org",
		"pandoc",
		"plaintex",
		"quarto",
		"mail",
		"mdx",
		"rmd",
		"rnoweb",
		"rst",
		"tex",
		"text",
		"typst",
		"xhtml",
	},
	root_markers = { ".git" },
	get_language_id = function(_, filetype)
		return language_id_mapping[filetype] or filetype
	end,
	settings = {
		ltex = {
			settings = {
				ltex = {
					enabled = {
						"asciidoc",
						"bib",
						"context",
						"gitcommit",
						"html",
						"markdown",
						"org",
						"pandoc",
						"plaintex",
						"quarto",
						"mail",
						"mdx",
						"rmd",
						"rnoweb",
						"rst",
						"tex",
						"latex",
						"text",
						"typst",
						"xhtml",
					},
					language = "pl-PL",
					additionalLangs = {
						"ar",
						"ast-ES",
						"be-BY",
						"br-FR",
						"ca-ES",
						"ca-ES-valencia",
						"zh-CN",
						"da-DK",
						"nl",
						"nl-BE",
						"en",
						"en-AU",
						"en-CA",
						"en-GB",
						"en-NZ",
						"en-ZA",
						"en-US",
						"eo",
						"fr",
						"gl-ES",
						"de",
						"de-AT",
						"de-DE",
						"de-CH",
						"el-GR",
						"ga-IE",
						"it",
						"ja-JP",
						"km-KH",
						"fa",
						"pt",
						"pt-AO",
						"pt-BR",
						"pt-MZ",
						"pt-PT",
						"ro-RO",
						"ru-RU",
						"de-DE-x-simple-language",
						"sk-SK",
						"sl-SI",
						"es",
						"es-AR",
						"sv",
						"tl-PH",
						"ta-IN",
						"uk-UA",
					},
					-- Automatyczne mapowanie słowników dla ltex-utils
					dictionary = (function()
						local dicts = {}
						local all_langs = {
							"pl-PL",
							"ar",
							"ast-ES",
							"be-BY",
							"br-FR",
							"ca-ES",
							"ca-ES-valencia",
							"zh-CN",
							"da-DK",
							"nl",
							"nl-BE",
							"en",
							"en-AU",
							"en-CA",
							"en-GB",
							"en-NZ",
							"en-ZA",
							"en-US",
							"eo",
							"fr",
							"gl-ES",
							"de",
							"de-AT",
							"de-DE",
							"de-CH",
							"el-GR",
							"ga-IE",
							"it",
							"ja-JP",
							"km-KH",
							"fa",
							"pt",
							"pt-AO",
							"pt-BR",
							"pt-MZ",
							"pt-PT",
							"ro-RO",
							"ru-RU",
							"de-DE-x-simple-language",
							"sk-SK",
							"sl-SI",
							"es",
							"es-AR",
							"sv",
							"tl-PH",
							"ta-IN",
							"uk-UA",
						}
						for _, lang in ipairs(all_langs) do
							-- Wyciąga główny kod języka (np. "en" z "en-US") dla ltex-utils
							local short_lang = string.match(lang, "^(%a+)")
							dicts[lang] = { ":" .. vim.fn.stdpath("config") .. "/spell/" .. short_lang .. ".utf-8.add" }
						end
						return dicts
					end)(),
				},
			},
		},
	},
}
