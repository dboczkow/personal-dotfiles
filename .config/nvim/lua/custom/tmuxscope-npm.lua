local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Konfiguracja (domyślna + możliwość nadpisania)
local M = {
	package_managers = {
		npm = { lockfile = "package-lock.json", run_cmd = "npm run %s" },
		yarn = { lockfile = "yarn.lock", run_cmd = "yarn %s" },
		pnpm = { lockfile = "pnpm-lock.yaml", run_cmd = "pnpm run %s" },
		bun = { lockfile = "bun.lockb", run_cmd = "bun run %s" },
	},
	tmux_split = "v", -- "v" poziomo, "h" pionowo
	wait_key = "read", -- komenda do wstrzymania po wykonaniu
}

-- Wykrywanie package managera
local function detect_package_manager()
	local cwd = vim.fn.getcwd()
	for name, config in pairs(M.package_managers) do
		if vim.fn.filereadable(cwd .. "/" .. config.lockfile) == 1 then
			return name, config
		end
	end
	return "npm", M.package_managers.npm -- domyślnie npm
end

-- Parsowanie package.json
local function get_package_scripts()
	local json_file = vim.fn.findfile("package.json", ".;")
	if json_file == "" then
		print(" Brak package.json w projekcie!")
		return {}
	end

	local json = vim.fn.json_decode(vim.fn.readfile(json_file))
	local scripts = {}
	if json.scripts then
		for name, cmd in pairs(json.scripts) do
			table.insert(scripts, name .. ": " .. cmd)
		end
	end
	return scripts
end

-- Uruchamianie w tmux
local function run_in_tmux(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	actions.close(prompt_bufnr)

	if not selection or not selection.value then
		return
	end

	local script_name = selection.value:match("^([^:]+):")
	if not script_name then
		return
	end

	local pm_name, pm_config = detect_package_manager()
	local cmd = string.format(pm_config.run_cmd, script_name:gsub('"', '\\"'))
	local current_dir = vim.fn.getcwd()

	vim.fn.system(string.format(
		[[
    tmux split-window -%s -c "%s" "%s; %s"
  ]],
		M.tmux_split,
		current_dir,
		cmd,
		M.wait_key
	))

	print(" [" .. pm_name:upper() .. "] " .. cmd)
end

-- Główna funkcja
local function package_scripts_picker(opts)
	opts = opts or {}
	local scripts = get_package_scripts()
	if #scripts == 0 then
		return
	end

	local pm_name, pm_config = detect_package_manager()
	local title = string.format(" %s Scripts (%s)", pm_name:upper(), pm_config.lockfile)

	pickers
		.new({}, {
			prompt_title = title,
			finder = finders.new_table({ results = scripts }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(run_in_tmux)
				return true
			end,
		})
		:find()
end

-- Eksport z konfiguracją
M.setup = function(opts)
	M.package_managers = vim.tbl_extend("force", M.package_managers, opts.package_managers or {})
	M.tmux_split = opts.tmux_split or M.tmux_split
	M.wait_key = opts.wait_key or M.wait_key
end

-- Komendy i keymap
vim.api.nvim_create_user_command("NpmScripts", package_scripts_picker, {})
vim.api.nvim_create_user_command("PackageScripts", package_scripts_picker, {}) -- ogólna nazwa
vim.keymap.set("n", "<leader>ns", package_scripts_picker, { desc = "📦 Package Scripts" })

return M
