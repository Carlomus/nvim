return {
	"nvim-lua/plenary.nvim",
	require("plugins.jupyter"),
	require("plugins.ui"),
	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("config.nvimtree")
		end,
	},
	-- Quality of life
	require("plugins.qol"),
	-- lsp stuff
	require("plugins.lsp"),
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		opts = function()
			return require("config.telescope")
		end,
	},
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
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<A-.>", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },
			{ "<A-/>", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal terminal" },
			{ "<A-?>", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Vertical terminal" },
		},
		opts = {
			open_mapping = [[<c-\>]],
			size = 12,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
		},
	},
}
