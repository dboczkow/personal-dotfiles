return {
	{
		"jhofscheier/ltex-utils.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			-- "nvim-telescope/telescope-fzf-native.nvim", -- optional
		},
		opts = {
			dictionary = {
				path = vim.fn.stdpath("config") .. "/spell/",
				filename = function(lang)
					return string.match(lang, "^(%a+)-")
						.. "."
						.. vim.api.nvim_buf_get_option(0, "fileencoding")
						.. ".add"
				end,
				-- use vim internal dictionary to add unkown words
				use_vim_dict = true,
				-- show/suppress vim command output such as `spellgood` or `mkspell`
				vim_cmd_output = false,
			},
			rule_ui = {
				-- key to modify rule
				modify_rule_key = "<CR>",
				-- key to delete rule
				delete_rule_key = "d",
				-- key to cleanup deprecated rules
				cleanup_rules_key = "c",
				-- key to jump to respective place in file
				goto_key = "g",
				-- enable line numbers in preview window
				previewer_line_number = true,
				-- wrap lines in preview window
				previewer_wrap = true,
				-- options for creating new telescope windows
				telescope = { bufnr = 0 },
			},
			diagnostics = {
				-- time to wait for language tool to complete parsing document
				-- debounce time in milliseconds
				debounce_time_ms = 500,
				-- use diagnostics data for modifying hiddenFalsePositives rules
				diags_false_pos = true,
				-- use diagnostics data for modifying disabledRules rules
				diags_disable_rules = true,
			},
			-- set the ltex-ls ("ltex") or ltex-ls-plus backend ("ltex_plus")
			backend = "ltex_plus",
		},
	},
}
