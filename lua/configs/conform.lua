local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		css = { "prettier" },
		html = { "prettier" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},

	-- overrides
	formatters = {
		stylua = {
			prepend_args = {
				"--column-width",
				"100",
				"--indent-width",
				"4",
				"--call-parentheses",
				"Always",
			},
		},

		prettier = {
			prepend_args = {
				"--single-quote",
				"--print-width",
				"100",
				"--no-semi",
				"--tab-width",
				"4",
				"--use-tabs",
			},
		},

		black = {
			prepend_args = {
				"--line-length",
				"100",
				"--skip-string-normalization",
			},
		},
	},
}

return options
