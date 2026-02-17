-- Testóje spell czeking --

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- File handling
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/vim/history"
vim.opt.encoding = "utf-8"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Command-line
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10

-- Terminal
vim.o.shell = "/usr/bin/zsh"

-- History and completion
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Mouse support
vim.opt.mouse = "a"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Hightlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})

-- Buffer/window options
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.equalalways = false

-- Miscellaneous
vim.opt.errorbells = false
vim.opt.belloff = "all"
vim.opt.spell = true
vim.opt.spelllang = "en_us,pl"

vim.opt.updatetime = 300
vim.opt.clipboard = "unnamedplus"

-- Completion options
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- File format detection
vim.opt.fileformats = { "unix", "dos", "mac" }
