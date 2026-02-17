return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"luissimas/telescope-nodescripts.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					spell_suggest = {
						theme = "cursor",
					},
				},
				extensions = {
					-- file_browser = {
					--   cwd_to_path = true,
					--   theme = "ivy",
					--   hijack_netrw = true,
					-- },
					nodescripts = {
						command = "pnpm run",
						display_method = "h_split",
						theme = "dropdown",
					},
					["ui-select"] = {
						require("telescope.themes").get_cursor({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("nodescripts")
		end,
	},
}
