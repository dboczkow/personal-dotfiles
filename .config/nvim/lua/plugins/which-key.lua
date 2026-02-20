return {
	{
		"folke/which-key.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "helix",
				icons = {
					group = " ",
				},
			})

			local telescope = require("telescope.builtin")
			local dap = require("dap")
			local dap_ui = require("dap.ui.widgets")
			local noice = require("noice")
			local flash = require("flash")

			local function get_project_root()
				local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
				local result = handle:read("*a")
				handle:close()
				result = result:gsub("%s+$", "") -- usuń końcowe białe znaki
				if result == "" then
					result = vim.fn.getcwd()
				end
				return result
			end

			local function create_file_in_project()
				local root = get_project_root()
				local input = vim.fn.input("Nazwa pliku (relatywnie do " .. root .. "): ")

				if input == "" then
					print("Nie podano nazwy pliku")
					return
				end

				local full_path = root .. "/" .. input

				vim.cmd("edit " .. full_path)
			end

			local save_as = function()
				local filename = vim.fn.input("Save as:")
				if filename ~= "" then
					vim.cmd("saveas " .. filename)
				end
			end

			local terminalSmall = function()
				vim.cmd("15split")
				vim.cmd("terminal")
			end

			local closeTerminal = function()
				vim.cmd("bd!")
			end

			local toggleFullscreenTerminal = function()
				if #vim.api.nvim_list_wins() == 1 then
					vim.cmd("15split")
				else
					vim.cmd("tab split")
				end
			end

			local git = function()
				vim.cmd("vsplit")
				vim.cmd("terminal lazygit")
				vim.cmd("startinsert")
			end

			wk.add({
				{ "<leader>", desc = "Menu" },
				{ "<leader>c", group = "Code" },
				{ "<leader>ci", vim.cmd.Mason, desc = "Install Language Server" },
				{ "<leader>ca", vim.lsp.buf.code_action, desc = "Action" },
				{ "<leader>cr", telescope.lsp_references, desc = "References" },
				{ "<leader>cf", vim.lsp.buf.format, desc = "Format" },

				{ "<leader>cg", group = "Go To" },
				{ "<leader>cgd", vim.lsp.buf.definition, desc = "Definition" },
				{ "<leader>cgD", vim.lsp.buf.declaration, desc = "Declaration" },
				{ "<leader>cgi", vim.lsp.buf.implementation, desc = "Implementation" },

				{ "<leader>cl", group = "Lint" },
				{ "<leader>clh", vim.diagnostic.goto_prev, desc = "Previous" },
				{ "<leader>cll", vim.diagnostic.goto_next, desc = "Next" },

				{ "<leader>cs", telescope.spell_suggest, desc = "Spell suggestion" },

				{ "<leader>d", group = "Debugger" },
				{ "<leader>dc", dap.continue, desc = "Continue" },

				{ "<leader>db", group = "Breakpoint" },
				{ "<leader>dbt", dap.toggle_breakpoint, desc = "Toggle" },
				{ "<leader>dbs", dap.set_breakpoint, desc = "Set" },
				{
					"<leader>dbl",
					function()
						dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
					end,
					desc = "Log point",
				},

				{ "<leader>dt", group = "Tooltip" },
				{ "<leader>dtt", dap_ui.hover, desc = "Toggle" },
				{ "<leader>dtf", dap_ui.hover, desc = "Frames" },
				{ "<leader>dts", dap_ui.hover, desc = "Scopes" },

				{ "<leader>ds", group = "Step" },
				{ "<leader>dso", dap.step_over, desc = "Over" },
				{ "<leader>dsi", dap.step_into, desc = "Into" },
				{ "<leader>dsa", dap.step_out, desc = "Out" },

				{ "<leader>n", group = "New", icon = "" },
				{ "<leader>ns", ":enew<cr>", desc = "Scratch file", icon = "󱞂" },
				{ "<leader>nf", create_file_in_project, desc = "File", icon = "" },

				{ "<leader>o", group = "Open", icon = "" },
				{ "<leader>ob", ":Yazi<cr>", desc = "Browse File" },
				{ "<leader>op", group = "Project" },
				{ "<leader>of", telescope.find_files, desc = "File" },

				{ "<leader>e", group = "Edit", icon = "" },
				{ "<leader>er", vim.lsp.buf.rename, desc = "Refactor" },
				{ "<leader>ef", group = "File" },
				{ "<leader>efq", ":hol<CR>", desc = "Cancel" },
				{ "<leader>eff", telescope.live_grep, desc = "Find" },

				{ "<leader>s", group = "Save", icon = { icon = "", color = "green" } },
				{ "<leader>ss", ":w<CR>", desc = "Save" },
				{ "<leader>sS", ":w!<CR>", desc = "Force Save" },
				{ "<leader>s<C-s>", ":wa!<CR>", desc = "Force Save all" },
				{ "<leader>sa", save_as, desc = "As ..." },
				{ "<leader>sA", ":wa<CR>", desc = "All" },

				{ "<leader>b", group = "Buffer", icon = "" },
				{ "<leader>bt", ":Telescope buffers<CR>", desc = "List", icon = { icon = "", color = "blue" } },
				{ "<leader>bq", ":bd<CR>", group = "Quit", icon = "󰜺" },

				{ "<leader>bqy", ":bd<CR>", desc = "Yes", icon = { icon = "", color = "green" } },
				{ "<leader>bqq", ":bd<CR>", desc = "", icon = "" },
				{ "<leader>bqQ", ":bd!<CR>", desc = "Yes, Im sure!", icon = { icon = "", color = "yellow" } },
				{ "<leader>bqY", ":bd!<CR>", desc = "", icon = "" },
				{ "<leader>bqn", desc = "No", icon = { icon = "󰜺 ", color = "red" } },

				{ "<leader>bh", ":bprev<CR>", desc = "Previous", icon = "" },
				{ "<leader>bl", ":bnext<CR>", desc = "Next", icon = "" },

				{ "<leader>`", group = "Terminal" },
				{ "<leader>`n", group = "New", icon = "" },
				{ "<leader>`nf", ":terminal<CR>", desc = "Fullscreen", icon = "" },
				{ "<leader>`ns", terminalSmall, desc = "Small", icon = "󱂩" },

				{ "<leader>g", git, desc = "Git" },

				{ "<leader>q", group = "Quit/Close" },
				{ "<leader>qy", ":q<CR>", desc = "Yes", icon = { icon = "", color = "green" } },
				{ "<leader>qq", ":q<CR>", desc = "", icon = "" },
				{ "<leader>qY", ":q!<CR>", desc = "Yes, Im sure!", icon = { icon = "", color = "yellow" } },
				{ "<leader>qn", desc = "No", icon = { icon = "󰜺", color = "red" } },

				{ "<leader>v", group = "View" },
				{ "<leader>vs", group = "Split" },
				{ "<leader>vsh", "split<CR>", desc = "Horizontal", icon = "" },
				{ "<leader>vsv", ":vsplit<CR>", desc = "Vertical", icon = "" },

				{ "<leader>vt", group = "Tab" },
				{ "<leader>vth", ":tabprev<cr>", desc = "previous", icon = "" },
				{ "<leader>vtl", ":tabprev<cr>", desc = "next", icon = "" },
				{ "<leader>vtn", ":tabnew<cr>", desc = "new", icon = "󰝜" },
				{ "<leader>vtq", ":tabclose<cr>", desc = "close", icon = "󰭌" },
				{ "<leader>vt", group = "tabs" },

				{ "<leader>?", ":VimMoves<CR>", desc = "Help", icon = "󰞋" },
				{
					mode = { "t" },
					{ "C<leader>q", closeTerminal, desc = "Quit" },
					{ "C<leader>f", toggleFullscreenTerminal, desc = "Fullscreen" },
				},
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "tex",
				callback = function()
					wk.add({
						{ "<leader>l", group = "LaTeX", icon = { icon = "", color = "green" }, buffer = true },

						{ "<leader>lS", group = "Status", icon = { icon = "", color = "blue" }, buffer = true },
						{
							"<leader>lSs",
							":VimtexStatus<cr>",
							icon = { icon = "", color = "blue" },
							desc = "Show",
							buffer = true,
						},
						{
							"<leader>lSa",
							":VimtexStatusAll<cr>",
							icon = { icon = "", color = "blue" },
							desc = "Show for all",
							buffer = true,
						},

						{ "<leader>li", group = "Info", icon = { icon = "", color = "white" }, buffer = true },
						{
							"<leader>liL",
							":VimtexImapsList<cr>",
							icon = { icon = "", color = "blue" },
							desc = "Imaps List",
							buffer = true,
						},
						{
							"<leader>lil",
							":VimtexLog<cr>",
							icon = { icon = "", color = "yellow" },
							desc = "Log",
							buffer = true,
						},
						{
							"<leader>lie",
							":VimtexErrors<cr>",
							icon = { icon = "", color = "red" },
							desc = "Errors",
							buffer = true,
						},
						{
							"<leader>lii",
							":VimtexInfo<cr>",
							icon = { icon = "", color = "white" },
							desc = "Info",
							buffer = true,
						},
						{
							"<leader>lif",
							":VimtexInfoFull<cr>",
							icon = { icon = "", color = "white" },
							desc = "Full info",
							buffer = true,
						},

						{ "<leader>ls", group = "Stop", icon = { icon = "󰜺", color = "red" }, buffer = true },
						{
							"<leader>lss",
							":VimtexStop<cr>",
							icon = { icon = "", color = "red" },
							desc = "Stop",
							buffer = true,
						},
						{
							"<leader>lsa",
							":VimtexStopAll<cr>",
							icon = { icon = "󰪧", color = "red" },
							desc = "Stop all",
							buffer = true,
						},

						{ "<leader>lc", group = "Compile", icon = { icon = "" }, buffer = true },
						{
							"<leader>lcc",
							":VimtexClean<cr>",
							icon = { icon = "", color = "red" },
							desc = "Clean",
							buffer = true,
						},
						{
							"<leader>lcf",
							":VimtexCleanFull<cr>",
							icon = { icon = "", color = "red" },
							desc = "Full Clean",
							buffer = true,
						},
						{
							"<leader>lcr",
							":VimtexCompile<cr>",
							icon = { icon = "", color = "green" },
							desc = "Run",
							buffer = true,
						},
						{
							"<leader>lcs",
							":VimtexCompileSelected<cr>",
							icon = { icon = "󰘦", color = "yellow" },
							desc = "Selected",
							buffer = true,
						},
						{
							"<leader>lco",
							":VimtexcompileOutput<cr>",
							icon = { icon = "", color = "blue" },
							desc = "Output",
							buffer = true,
						},

						{
							"<leader>lt",
							group = "Table of Content",
							icon = { icon = "", color = "orange" },
							buffer = true,
						},
						{
							"<leader>lto",
							":VimtexTocOpen<cr>",
							icon = { icon = "", color = "orange" },
							desc = "Open",
							buffer = true,
						},
						{
							"<leader>ltt",
							":VimtexTocToggle<cr>",
							icon = { icon = "󰨚", color = "orange" },
							desc = "Toggle",
							buffer = true,
						},

						{ "<leader>lr", group = "Reload", icon = { icon = "󰑓", color = "blue" }, buffer = true },
						{
							"<leader>lrr",
							":VimtexReload<cr>",
							icon = { icon = "󰑓", color = "blue" },
							desc = "Reload",
							buffer = true,
						},
						{
							"<leader>lrs",
							":VimtexReloadState<cr>",
							icon = { icon = "󱇯", color = "blue" },
							desc = "Reload State",
							buffer = true,
						},

						{
							"<leader>lv",
							":VimtexView<cr>",
							icon = { icon = "", color = "green" },
							desc = "View",
							buffer = true,
						},
					})
				end,
			})

			local root = get_project_root()
			local pkg_path = root .. "/package.json"
			if root == "" then
				root = vim.fn.getcwd()
			end

			if vim.fn.filereadable(pkg_path) == 1 then
				wk.add({
					{ "<leader>r", group = "Run", icon = { icon = "", color = "green" } },
					{
						"<leader>rs",
						":lua require('telescope').extensions.nodescripts.run({})<CR>",
						desc = "Scripts",
						icon = { icon = "󰯁", color = "yellow" },
					},
					{ "<leader>rp", group = "Packages", icon = { icon = "󰏓", color = "green" } },
					{ "<leader>rp", ":!npm install<CR>", desc = "Install", icon = { icon = "󰏔", color = "blue" } },
					{ "<leader>rd", ":!npm update<CR>", desc = "Update", icon = { icon = "󰏕", color = "green" } },
				})
			end

			local cs_project_extentions = { "csproj", "fsproj", "vbproj", "sln", "props", "targets", "cs", "fs", "vb" }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = cs_project_extentions,
				callback = function()
					wk.add({
						{ "<leader>cd", group = "Dotnet", icon = { icon = "󰪮", color = "purple" }, buffer = true },
						{ "<leader>cdc", group = "Create", icon = { icon = "", color = "green" }, buffer = true },
						{
							"<leader>cdcp",
							":Dotnet new <CR>",
							desc = "Project",
							icon = { icon = "󰉗", color = "green" },
							buffer = true,
						},
						{
							"<leader>cdcf",
							":Dotnet createfile <CR>",
							desc = "File",
							icon = { icon = "󰝒", color = "green" },
							buffer = true,
						},
						{ "<leader>cdr", group = "Run", icon = { icon = "", color = "green" }, buffer = true },
						{
							"<leader>cdrr",
							":Dotnet run<CR>",
							desc = "Run",
							icon = { icon = "", color = "green" },
							buffer = true,
						},
						{
							"<leader>cdrb",
							":Dotnet build<CR>",
							desc = "Build",
							icon = { icon = "", color = "blue" },
							buffer = true,
						},
						{
							"<leader>cdrd",
							":Dotnet debug<CR>",
							desc = "Debug",
							icon = { icon = "", color = "red" },
							buffer = true,
						},
						{
							"<leader>cdrt",
							":Dotnet test<CR>",
							desc = "Test",
							icon = { icon = "󰙨", color = "yellow" },
							buffer = true,
						},
						{ "<leader>cdl", group = "LSP", icon = { icon = "", color = "green" }, buffer = true },
						{
							"<leader>cdlS",
							":Dotnet lsp stop<CR>",
							desc = "Stop",
							icon = { icon = "", color = "red" },
							buffer = true,
						},
						{
							"<leader>cdls",
							":Dotnet lsp start<CR>",
							desc = "Start",
							icon = { icon = "", color = "green" },
							buffer = true,
						},
						{
							"<leader>cdlr",
							":Dotnet lsp restart<CR>",
							desc = "Restart",
							icon = { icon = "", color = "blue" },
							buffer = true,
						},
					})
				end,
			})

			local function merge_conflict_keys(bufnr)
				wk.add({
					{ "<leader>m", group = "Merge conflict", icon = { icon = "", color = "red" }, buffer = bufnr },

					{ "<leader>mm", group = "Merge", icon = { icon = "", color = "red" }, buffer = bufnr },
					{
						"<leader>mmh",
						":diffget LOCAL<CR>",
						icon = { icon = "", color = "green" },
						desc = "Left (Local)",
						buffer = bufnr,
					},
					{
						"<leader>mml",
						":diffget REMOTE<CR>",
						icon = { icon = "", color = "green" },
						desc = "Right (Remote)",
						buffer = bufnr,
					},
					{
						"<leader>mmb",
						":diffget BASE<CR>",
						icon = { icon = "", color = "blue" },
						desc = "Center (Base)",
						buffer = bufnr,
					},

					{
						"<leader>mj",
						"]c",
						icon = { icon = "", color = "yellow" },
						desc = "Next conflict",
						buffer = bufnr,
					},
					{
						"<leader>mk",
						"[c",
						icon = { icon = "", color = "yellow" },
						desc = "Previous conflict",
						buffer = bufnr,
					},

					{
						"<leader>mq",
						":cq<CR>",
						icon = { icon = "󰩈", color = "yellow" },
						desc = "Exit merge tool",
						buffer = bufnr,
					},

					{ "<leader>md", group = "Diff", icon = { icon = "", color = "red" }, buffer = bufnr },
					{
						"<leader>mdu",
						":diffupdate<CR>",
						icon = { icon = "󰚰", color = "blue" },
						desc = "Update diff",
						buffer = bufnr,
					},
					{
						"<leader>mdq",
						":diffoff!<CR>",
						icon = { icon = "", color = "red" },
						desc = "Toggle diff off",
						buffer = bufnr,
					},
				})
			end

			vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
				callback = function(args)
					local bufnr = args.buf

					-- upewnij się, że which-key już istnieje
					local ok = pcall(require, "which-key")
					if not ok then
						return
					end

					-- sprawdź diff albo markery konfliktu
					local is_diff = vim.opt.diff:get()
					local has_conflict = false
					local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
					for _, line in ipairs(lines) do
						if line:match("^<<<<<<<") then
							has_conflict = true
							break
						end
					end

					if is_diff or has_conflict then
						merge_conflict_keys(bufnr)
					end
				end,
			})
			vim.keymap.set("n", "s", function()
				wk.show("s")
			end)

			vim.keymap.set("t", "<C-SPACE>", function()
				wk.show("C<leader>")
			end)

			vim.keymap.set("n", "<C-.>", function()
				vim.lsp.buf.hover({
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				})
			end, { noremap = true, silent = true, desc = "LSP Hover" })
			vim.keymap.set("n", "w", function()
				require("flash").toggle()
			end)

			vim.keymap.set("n", "<C-d>", "<C-d>zz")
			vim.keymap.set("n", "<C-u>", "<C-u>zz")
			vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected part down" })
			vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected part up" })
			vim.keymap.del("n", "<C-d>")
			vim.keymap.del("n", "<C-u>")
			vim.keymap.set("n", "<Esc>", function()
				noice.cmd("dismiss")
			end, { desc = "Dismiss notification" })
			vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
			vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
		end,
	},
}
