M = {
	{
		"nvim-tree/nvim-web-devicons",
		opts = function() end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "LspAttach",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				line_numbers = true,
				max_lines = 5,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = { "BufNew", "BufEnter" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					separator_style = "thick",
					show_buffer_close_icons = false,
					show_close_icon = false,
					enforce_regular_tabs = true,
					always_show_bufferline = true,
					numbers = "ordinal",
					indicator = {
						style = "underline",
					},
				},
			})
		end,
	},
	{
		-- lualine breadcrumbs
		"SmiteshP/nvim-navic",
		config = function()
			local config = require("config.navic")
			require("nvim-navic").setup(config)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
		lazy = false,
		config = function()
			local config = require("config.lualine")
			require("lualine").setup(config)
		end,
	},
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
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
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
}

return M
