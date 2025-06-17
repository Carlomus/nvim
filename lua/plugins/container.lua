return {
	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
		-- config = function()
		-- return require("remote-nvim").setup({ devpod = { binary = "devpod-cli" } })
		-- end,
	},
	-- { "jamestthompson3/nvim-remote-containers", lazy = false },
	-- {
	-- 	"https://codeberg.org/esensar/nvim-dev-container",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	lazy = false,
	-- 	config = function()
	-- 		return require("devcontainer").setup({})
	-- 	end,
	-- },
}
