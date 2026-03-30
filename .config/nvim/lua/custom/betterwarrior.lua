local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local M = {}
-- Helper do szybkich komend shell
local function sys(cmd)
	local f = io.popen(cmd)
	if not f then
		return ""
	end
	local s = f:read("*a")
	f:close()
	return s:gsub("%s+", "")
end

-- 1. START ZADANIA (Telescope)
function M.start_project_task()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local cmd =
		string.format("task project:%s status:pending rc.verbose=nothing export", vim.fn.shellescape(project_name))
	local output = vim.fn.system(cmd)
	local tasks = vim.fn.json_decode(output) or {}

	if #tasks == 0 then
		vim.notify("No tasks in project " .. project_name, vim.log.levels.WARN)
		return
	end

	pickers
		.new({}, {
			prompt_title = "Tasks: " .. project_name,
			finder = finders.new_table({
				results = tasks,
				entry_maker = function(entry)
					-- Formatuje status, np. "pending" -> "Pending"
					local status = (entry.status or "unknown"):gsub("^%l", string.upper)

					return {
						value = entry,
						-- %-4s  -> ID (wyrównane do 4 znaków)
						-- %-10s -> Status (wyrównane do 10 znaków)
						-- %s    -> Opis
						display = string.format(" %-4s │ %-10s │ %s", entry.id, status, entry.description),
						ordinal = entry.description .. " " .. status,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = previewers.new_buffer_previewer({
				title = "Task Detail",
				define_preview = function(self, entry)
					local t = entry.value

					local timew_cmd = 'timew summary "' .. t.description .. '" :all 2>/dev/null'
					local timew_out = vim.fn.systemlist(timew_cmd)

					local total_time = "0:00:00"
					local session_count = 0

					for i = #timew_out, 1, -1 do
						local line = timew_out[i]
						if total_time == "0:00:00" then
							total_time = line:match("(%d+:%d+:%d+)%s*$") or "0:00:00"
						end
						if line:match("^%s*@%d+") then
							session_count = session_count + 1
						end
					end

					local function format_date(date_str)
						if not date_str or date_str == "" then
							return ""
						end
						local y, m, d, hh, mm, ss = date_str:match("(%d%d%d%d)(%d%d)(%d%d)T(%d%d)(%d%d)(%d%d)Z")
						if y then
							return string.format("%s-%s-%s %s:%s:%s", y, m, d, hh, mm, ss)
						end
						return ""
					end

					local lines = {
						"Name                  Details",
						"──────────────────── ──────────────────────────────────────────────────",
						string.format(" ID:                 %s", t.id or ""),
						string.format(" UUID:               %s", t.uuid or ""),
						string.format(" Status:             %s", (t.status or "pending"):gsub("^%l", string.upper)),
						string.format("󰠥 Mask:               %s", t.mask or ""),
						string.format(" iMask:              %s", t.imask or ""),
						string.format(" Project:            %s", t.project or ""),
						string.format(" Tags:               %s", t.tags and table.concat(t.tags, " ") or ""),
						string.format(" Description:        %s", t.description or ""),
						string.format("󰙴 Created:            %s", format_date(t.entry)),
						string.format(" Started:            %s", format_date(t.start)),
						string.format(" Ended:              %s", format_date(t.end_date)),
						string.format(" Tracked:            %s", total_time),
						string.format(" Scheduled:          %s", t.scheduled or ""),
						string.format("󰃰 Due:                %s", format_date(t.due)),
						string.format("󱙬 Until:              %s", format_date(t["until"])),
						string.format("󰇡 Recur:              %s", t.recur or ""),
						string.format(" Wait until:         %s", format_date(t.wait)),
						string.format(" Modified:           %s", format_date(t.modified)),
						string.format(" Parent:             %s", t.parent or ""),
					}

					-- Obsługa adnotacji
					if t.annotations and #t.annotations > 0 then
						for i, ann in ipairs(t.annotations) do
							local prefix = (i == 1) and "󱓥 Annotation:         " or "                      "
							table.insert(
								lines,
								string.format("%s%s -- %s", prefix, format_date(ann.entry), ann.description)
							)
						end
					else
						table.insert(lines, "󱓥 Annotation:         ")
					end

					table.insert(lines, string.format(" Dependencies:       %s", t.depends or ""))
					table.insert(lines, string.format("󰘃 UDA priority:       %s", t.priority or ""))

					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
					vim.bo[self.state.bufnr].filetype = "taskedit"
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					vim.fn.system("task +ACTIVE stop")
					vim.fn.system("task " .. selection.value.id .. " start")
					vim.notify("󰱛 Start: " .. selection.value.description)
				end)
				return true
			end,
		})
		:find()
end

function M.task_add_wizard()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local new_task = { project = project_name }

	-- KROK 1: Opis
	vim.ui.input({ prompt = " Description: " }, function(desc)
		if not desc or desc == "" then
			return
		end
		new_task.description = desc

		-- KROK 2: Tagi
		local all_tags_raw = vim.fn.systemlist("task tags rc.verbose=nothing")
		local all_tags = { "None" }

		-- Czyścimy wynik komendy 'task tags'
		for _, line in ipairs(all_tags_raw) do
			-- Wyciągamy pierwszy ciąg znaków
			local tag_name = line:match("^(%S+)")

			-- FILTR: Pomijamy puste linie, nagłówek "Tag" oraz kreski "---"
			if tag_name and tag_name ~= "" and tag_name:lower() ~= "tag" and not tag_name:match("^%-+$") then
				table.insert(all_tags, tag_name)
			end
		end

		pickers
			.new({}, {
				prompt_title = " Select/Create tag:",
				finder = finders.new_table({
					results = all_tags,
				}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(prompt_bufnr)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						local current_input = action_state.get_current_line()
						actions.close(prompt_bufnr)

						local final_tag = nil
						-- selection[1] to teraz czysta nazwa tagu dzięki pętli powyżej
						if selection and selection[1] ~= "None" then
							final_tag = selection[1]
						elseif current_input ~= "" and current_input ~= "None" then
							-- Jeśli użytkownik wpisał własny tag, też go bierzemy
							final_tag = current_input
						end

						new_task.tag = final_tag

						-- KROK 3: Until
						vim.ui.input({ prompt = "󱙬 Until (tomorrow, 24h): " }, function(until_val)
							new_task.until_date = until_val

							-- KROK 4: Dependencies
							local tasks_output = vim.fn.system(
								string.format("task project:%s status:pending export", vim.fn.shellescape(project_name))
							)
							local tasks = vim.fn.json_decode(tasks_output) or {}

							-- Dodajemy opcję 'Brak' na początku listy zadań
							local dep_results = { { id = "0", description = "None", uuid = nil } }
							for _, t in ipairs(tasks) do
								table.insert(dep_results, t)
							end

							pickers
								.new({}, {
									prompt_title = " Dependencies:",
									finder = finders.new_table({
										results = dep_results,
										entry_maker = function(entry)
											return {
												value = entry.uuid,
												display = string.format("%-4s │ %s", entry.id, entry.description),
												ordinal = entry.description,
											}
										end,
									}),
									attach_mappings = function(dep_bufnr)
										actions.select_default:replace(function()
											local dep_sel = action_state.get_selected_entry()
											actions.close(dep_bufnr)
											new_task.depends = dep_sel and dep_sel.value or nil

											local priority_opts = {
												{ id = "H", label = "High", icon = "" },
												{ id = "M", label = "Medium", icon = "" },
												{ id = "L", label = "Low", icon = "" },
												{ id = "none", label = "None", icon = "󰰚" }, -- Opcjonalna ikona dla braku priorytetu
											}

											-- KROK 5: Priority
											local priority_opts = {
												{ id = "none", label = "None", icon = " " }, -- Opcjonalna ikona dla braku priorytetu
												{ id = "L", label = "Low", icon = " " },
												{ id = "M", label = "Medium", icon = " " },
												{ id = "H", label = "High", icon = " " },
											}

											pickers
												.new({}, {
													prompt_title = "󰘃 Priority:",
													finder = finders.new_table({
														results = priority_opts,
														entry_maker = function(entry)
															return {
																value = entry.id,
																-- Formatujemy wygląd linii w Telescope:
																display = string.format(
																	"%s    │ %s",
																	entry.icon,
																	entry.label
																),
																ordinal = entry.label, -- Po czym Telescope ma szukać (np. wpiszesz "High")
															}
														end,
													}),
													attach_mappings = function(pri_bufnr)
														actions.select_default:replace(function()
															local pri_sel = action_state.get_selected_entry()
															actions.close(pri_bufnr)

															-- Pobieramy czystą wartość (H, M, L lub none)
															local val = pri_sel and pri_sel.value or "none"
															new_task.priority = (val ~= "none") and val or nil

															-- FINALIZACJA I BUDOWANIE KOMENDY
															local cmd = string.format(
																"task add project:%s %s",
																vim.fn.shellescape(new_task.project),
																vim.fn.shellescape(new_task.description)
															)

															if new_task.tag then
																cmd = cmd .. " +" .. new_task.tag
															end
															if new_task.until_date and new_task.until_date ~= "" then
																cmd = cmd .. " until:" .. new_task.until_date
															end
															if new_task.depends then
																cmd = cmd .. " depends:" .. new_task.depends
															end
															if new_task.priority then
																cmd = cmd .. " priority:" .. new_task.priority
															end

															vim.fn.system(cmd)
															vim.notify(" Task added: " .. new_task.description)
														end)
														return true
													end,
												})
												:find()
										end)
										return true
									end,
								})
								:find()
						end)
					end)
					return true
				end,
			})
			:find()
	end)
end

-- 6. KOŃCZENIE ZADANIA (TaskDone)
function M.task_done()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

	-- Pobieramy tylko zadania oczekujące (pending) dla tego projektu
	local cmd =
		string.format("task project:%s status:pending rc.verbose=nothing export", vim.fn.shellescape(project_name))
	local output = vim.fn.system(cmd)
	local tasks = vim.fn.json_decode(output) or {}

	if #tasks == 0 then
		vim.notify("None tasks in project: " .. project_name, vim.log.levels.WARN)
		return
	end

	pickers
		.new({}, {
			prompt_title = "Close Task: " .. project_name,
			finder = finders.new_table({
				results = tasks,
				entry_maker = function(entry)
					local status = (entry.status or "unknown"):gsub("^%l", string.upper)
					return {
						value = entry,
						display = string.format("%-4s │ %-10s │ %s", entry.id, status, entry.description),
						ordinal = entry.id .. " " .. entry.description .. " " .. status,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)

					local task_id = selection.value.id
					local task_desc = selection.value.description

					-- 1. Zatrzymaj timer jeśli to zadanie było aktywne
					vim.fn.system("task " .. task_id .. " stop 2>/dev/null")

					-- 2. Oznacz jako DONE
					local result = vim.fn.system("task " .. task_id .. " done")

					if result:find("Completed") or result:find("zakończone") or result == "" then
						vim.notify(" Task completed: " .. task_desc, vim.log.levels.INFO)
					else
						vim.notify("Error during cloasing task: " .. result, vim.log.levels.ERROR)
					end
				end)
				return true
			end,
		})
		:find()
end

function M.check_project_todays_tasks()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

	local cmd = string.format(
		"task project:%s until:today status:pending count rc.verbose=nothing",
		vim.fn.shellescape(project_name)
	)

	local count_str = vim.fn.system(cmd):gsub("%s+", "")
	local n_count = tonumber(count_str) or 0

	if n_count > 0 then
		vim.defer_fn(function()
			vim.notify(
				string.format("󱙬 Project [%s]: You have %d task to do until today!", project_name, n_count),
				vim.log.levels.WARN,
				{ title = "Task", icon = "" }
			)
		end, 800)
	end
end
-- 2. FUNKCJA DLA LUALINE
function M.get_task_status()
	local duration_iso = sys("timew get dom.active.duration 2>/dev/null")

	if duration_iso == "" or duration_iso == "PT0S" then
		return ""
	end

	local h = duration_iso:match("(%d+)H") or "00"
	local m = duration_iso:match("(%d+)M") or "00"
	local s = duration_iso:match("(%d+)S") or "00"

	return string.format("󱎫 %02dH %02dM %02dS", tonumber(h), tonumber(m), tonumber(s))
end

-- 3. AUTOMATYZACJA I KOMENDY
vim.api.nvim_create_user_command("TaskStart", M.start_project_task, {})
vim.api.nvim_create_user_command("TaskStop", function()
	vim.fn.system("task +ACTIVE stop")
end, {})
vim.api.nvim_create_user_command("TaskDone", M.task_done, {})
vim.api.nvim_create_user_command("TaskAdd", M.task_add_wizard, {})

local group = vim.api.nvim_create_augroup("TaskWarriorHooks", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		-- WAŻNE: Nazwa tutaj MUSI zgadzać się z nazwą funkcji powyżej
		M.check_project_todays_tasks()
	end,
})
vim.api.nvim_create_autocmd({ "VimLeave", "DirChanged" }, {
	group = group,
	callback = function()
		vim.fn.system("task +ACTIVE stop")
	end,
})

return M
