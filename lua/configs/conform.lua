local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		css = { "prettier" },
		html = { "prettier" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},

	formatters = {
		prettier = {
			-- use single quotes, 100-col wrap, keep semicolons
			prepend_args = {
				"--single-quote",
				"--print-width",
				"100",
				"--no-semi",
				"tab-width",
				"4",
				"use-tabs",
				"true",
			},
		},
		black = {
			--  line length 100, do NOT touch quotes
			prepend_args = { "--line-length", "100" },
		},
	},
}

return options
