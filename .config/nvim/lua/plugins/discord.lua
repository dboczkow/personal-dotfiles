return {
	{
		"vyfor/cord.nvim",
		---@type CorConfig
		opts = {
			enable = true,
			editor = {
				client = "neovim",
				tooltip = "Personal Development Enviroment",
			},
			display = {
				theme = "catppuccin",
				flavor = "accent",
				view = "full",
			},
			timestamp = {
				enabled = true,
			},
			idle = {
				enabled = true,
				timeout = 300000,
				show_status = true,
				ignore_focus = true,
				unidle_on_focus = true,
				smart_idle = true,
				details = "Bezczynny",
				state = nil,
				tooltip = "💤",
				icon = nil,
			},
			text = {
				default = nil,
				workspace = function(opts)
					return "W " .. opts.workspace
				end,
				viewing = function(opts)
					return "Przegląda " .. opts.filename
				end,
				editing = function(opts)
					return "Edytuje " .. opts.filename
				end,
				file_browser = function(opts)
					return "Przegląda pliki w  " .. opts.name
				end,
				plugin_manager = function(opts)
					return "Zarządza wtyczkami w " .. opts.name
				end,
				lsp = function(opts)
					return "Konfiguruje LSP w " .. opts.name
				end,
				docs = function(opts)
					return "Czyta " .. opts.name
				end,
				vcs = function(opts)
					return "Commituje zmiany w " .. opts.name
				end,
				notes = function(opts)
					return "Robi notatki w " .. opts.name
				end,
				debug = function(opts)
					return "Debuguje w " .. opts.name
				end,
				test = function(opts)
					return "Testuje w " .. opts.name
				end,
				diagnostics = function(opts)
					return "Naprawia błędy w " .. opts.name
				end,
				games = function(opts)
					return "Gra w " .. opts.name
				end,
				terminal = function(opts)
					return "Uruchamia komendę " .. opts.name
				end,
				dashboard = "Ekran główny",
			},
		},
	},
}
