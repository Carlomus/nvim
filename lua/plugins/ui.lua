M = {
	{
		"nvim-tree/nvim-web-devicons",
		opts = function() end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "LspAttach",
		config = function()
			require("treesitter-context").setup(require("config.treectx"))
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
		-- Lualine breadcrumbs
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
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		opts = {
			indent = {
				char = "¦",
				highlight = { "IblIndent" },
			},
			scope = {
				enabled = true,
				char = "│",
				show_start = false,
				show_end = false,
				highlight = { "IblScope" },
			},
		},
		config = function(_, opts)
			local ibl = require("ibl")
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			ibl.setup(opts)
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter", -- load on startup
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- get the table you just returned from config/alpha.lua
			local ok, opts = pcall(require, "config.alpha")
			if not ok or not opts then
				opts = require("alpha.themes.dashboard").config
			end
			require("alpha").setup(opts)
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
}

return M
