-- Dev override: load Mercury from the local working copy at
-- /Users/carlo/no_work/mercury so changes there take effect on the
-- next nvim restart without going through GitHub.
return {
	"Carlomus/mercury",
	dir = "/Users/carlo/no_work/mercury",
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
