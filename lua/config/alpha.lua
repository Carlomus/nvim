-- Alpha (dashboard) for neovim

local options = {}

-- Create button for initial keybind.
--- @param sc string
--- @param txt string
--- @param hl string
--- @param keybind string optional
local function button(sc, txt, hl, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = hl,
	}

	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true, nowait = true } }
	end

	local function on_press()
		local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "normal", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

-- All custom headers
local headers = require("others/headers")

--
-- Sections for Alpha.
--

local header = {
	type = "text",
	-- val = Headers[math.random(#Headers)],
	val = headers[1],
	opts = {
		position = "center",
		hl = "Whitespace",
		-- wrap = "overflow";
	},
}

local footer = {
	type = "text",
	val = "Hello there.",
	opts = { position = "center", hl = "Whitespace" },
}

local buttons = {
	type = "group",
	val = {
		button("e", "  New Buffer", "RainbowRed", ":tabnew<CR>"),
		button("f", "  Find file", "RainbowYellow", ":Telescope find_files<CR>"),
		button("h", "  Recently opened files", "RainbowBlue", ":Telescope oldfiles<CR>"),
		button("l", "  Projects", "RainbowOrange", ":Telescope marks<CR>"),
		--button("r", "  Frecency/MRU",          'RainbowCyan', ':Telescope oldfiles<CR>'),
		button(
			"g",
			"  Open Last Session",
			"RainbowGreen",
			":source ~/.config/nvim/session.vim<CR>"
		),
		--button("m", "  Word Finder",           'RainbowViolet', ':Telescope live_grep<CR>'),
	},
	opts = {
		spacing = 1,
	},
}

--
-- Centering handler of ALPHA
--

local ol = { -- occupied lines
	icon = #header.val, -- CONST: number of lines that your header will occupy
	message = #footer.val, -- CONST: because of padding at the bottom
	length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
	neovim_lines = 2, -- CONST: 2 of command line, 1 of the top bar
	padding_between = 3, -- STATIC: can be set to anything, padding between keybinds and header
}

local left_terminal_value = vim.o.lines
	- (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)

-- Not screen enough to run the command.
if left_terminal_value >= 0 then
	local top_padding = math.floor(left_terminal_value / 2)
	local bottom_padding = left_terminal_value - top_padding

	--
	-- Set alpha sections
	--

	options = {
		layout = {
			{ type = "padding", val = top_padding },
			header,
			{ type = "padding", val = ol.padding_between },
			buttons,
			footer,
			{ type = "padding", val = bottom_padding },
		},
		opts = {
			margin = 5,
		},
	}
end

return options
