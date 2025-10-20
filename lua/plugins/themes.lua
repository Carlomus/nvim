M = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						-- Style to be applied to different syntax groups
						-- Value is any valid attr-list value `:help attr-list`
						comments = "italic",
						conditionals = "bold",
						constants = "bold",
						functions = "NONE",
						keywords = "bold",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
				},
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = false,
				italic_comments = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
}

return M
