local function toggle_boolean()
	local null_map = {
		python = "none",
		rust = "none",
		haskell = "nothing",
		lua = "nil",
		ruby = "nil",
		go = "nil",
		elixir = "nil",
		swift = "nil",
		perl = "undef",
		vb = "nothing",
		vba = "nothing",
	}

	local null_word = null_map[vim.bo.filetype] or "null"

	local transitions = {
		["true"] = "false",
		["false"] = null_word,
		[null_word] = "true",

		["nil"] = "true",
		["none"] = "true",
		["null"] = "true",
		["undef"] = "true",
		["nothing"] = "true",

		["0"] = "1",
		["1"] = "0",
	}

	local word = vim.fn.expand("<cword>")
	if not word or word == "" then
		return
	end

	local lower_word = word:lower()
	local target = transitions[lower_word]

	if target then
		if word == word:upper() and #word > 1 then
			target = target:upper()
		elseif word:sub(1, 1) == word:sub(1, 1):upper() then
			target = target:sub(1, 1):upper() .. target:sub(2):lower()
		else
			target = target:lower()
		end

		vim.cmd("normal! ciw" .. target)
	end
end

vim.keymap.set("n", "cv", toggle_boolean, { desc = "Toggle value" })
