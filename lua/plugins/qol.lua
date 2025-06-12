M = {
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		config = function()
			require("config.neoscroll")
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = false,
		cmd = "WhichKey",
		opts = function()
			return {}
		end,
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.conform")
		end,
	},
	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		opts = function()
			return require("config.gitsigns")
		end,
	},
	-- autopairing of (){}[] etc
	{
		"windwp/nvim-autopairs",
		lazy = false,
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- setup cmp for autopairs
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
	-- {
	-- 	"chrisgrieser/nvim-origami",
	-- 	event = "VeryLazy",
	-- 	opts = {}, -- needed even when using default config
	--
	-- 	-- recommended: disable vim's auto-folding
	-- 	init = function()
	-- 		vim.opt.foldlevel = 99
	-- 		vim.opt.foldlevelstart = 99
	-- 	end,
	-- },
}

return M
