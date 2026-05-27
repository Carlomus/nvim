-- To revert to a local dev override (load from
-- /Users/carlo/no_work/mercury directly without going through
-- GitHub), uncomment the `dir = ...` line below.
return {
	"Carlomus/mercury",
	-- dir = "/Users/carlo/no_work/mercury",
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
