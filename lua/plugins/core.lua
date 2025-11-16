return {
	"nvim-lua/plenary.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("config.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = function() end,
	},
	-- {
	-- 	"s1n7ax/nvim-window-picker",
	-- 	name = "window-picker",
	-- 	event = "VeryLazy",
	-- 	version = "2.*",
	-- 	config = function()
	-- 		require("window-picker").setup()
	-- 	end,
	-- },
	{
		"Carlomus/mercury",
		branch = "advanced_blocks",
		dependencies = { "3rd/image.nvim", "MeanderingProgrammer/render-markdown.nvim" },
		lazy = false,
		priority = 1000,
		config = function()
			require("mercury").setup({})
		end,
	},
}
