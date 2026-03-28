return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			search = {
				multi_window = false,
				incremental = true,
				exclude = {
					"notify",
					"cmp_menu",
					"noice",
					"flash_prompt",
					"blink_cmp",
					function(win)
						-- exclude non-focusable windows
						return not vim.api.nvim_win_get_config(win).focusable
					end,
				},
			},
			modes = {
				search = {
					enabled = true,
				},
			},
			prompt = {
				enabled = true,
				prefix = { { "", "FlashPromptIcon" } },
				win_config = {
					relative = "editor",
					border = "none",
					width = 1, -- when <=1 it's a percentage of the editor width
					height = 1,
					row = -1, -- when negative it's an offset from the bottom
					col = 0, -- when negative it's an offset from the right
					zindex = 1000,
				},
			},
		},
	},
}
