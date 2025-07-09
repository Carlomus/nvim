M = {
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		config = function()
			require("config.neoscroll")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.conform")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		opts = function()
			return require("config.gitsigns")
		end,
	},
}
return M
