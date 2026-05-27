return {
	"Carlomus/mercury",
	lazy = false,
	dependencies = {
		"3rd/image.nvim",
		"folke/snacks.nvim",
		"nvim-treesitter/nvim-treesitter",
		"MeanderingProgrammer/render-markdown.nvim",
	},
	config = function()
		require("mercury").setup({})
	end,
}
