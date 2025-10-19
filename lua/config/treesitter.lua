return {
	ensure_installed = {
		"lua",
		"luadoc",
		"printf",
		"vim",
		"vimdoc",
		"python",
		"rust",
		"c",
		"cpp",
		"markdown",
		"markdown_inline",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer", -- next function start
				["]]"] = "@class.outer", -- next class start
				["]p"] = "@parameter.inner", -- next parameter
				["]f"] = "@function.outer", -- extra alias for functions
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[p"] = "@parameter.inner",
				["[f"] = "@function.outer",
			},
			-- jump to END of things
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
}
