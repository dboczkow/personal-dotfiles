return {
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		main = "nvim-silicon",
		opts = {
			-- Configuration here, or leave empty to use defaults
			font = "JetBrainsMono Nerd Font",
			theme = "Dracula",
			background = "#0000",
			pad_horiz = 20,
			pad_vert = 20,
			tab_width = 2,
			shadow_blur_radius = 0,
			to_clipboard = true,
			window_title = function()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
			end,
			line_offset = function(args)
				return args.line1
			end,
		},
	},
}
