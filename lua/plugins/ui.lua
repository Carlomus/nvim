M = {
	{
		"nvim-tree/nvim-web-devicons",
		opts = function() end,
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
	-- { "SmiteshP/nvim-navic", event = "LspAttach", dependencies = { "neovim/nvim-lspconfig" } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			local config = require("config.lualine")
			require("lualine").setup(config)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- dependencies = { "SmiteshP/nvim-navic" },
		event = "BufReadPost",
		opts = {
			indent = {
				char = "┆",
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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
	-- {
	-- 	"rose-pine/neovim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
	-- { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000 },
	-- { "sainnhe/everforest", lazy = false, priority = 1000 },
	-- { "shaunsingh/nord.nvim", lazy = false, priority = 1000 },
	-- { "rmehri01/onenord.nvim", lazy = false, priority = 1000 },
	-- { "navarasu/onedark.nvim", lazy = false, priority = 1000 },
	-- { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
	{ "projekt0n/github-nvim-theme", lazy = false, priority = 1000 },
	-- { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
	-- { "ray-x/starry.nvim", lazy = false, priority = 1000 },
}

return M
