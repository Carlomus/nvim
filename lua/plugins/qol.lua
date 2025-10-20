local M = {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.conform")
		end,
	},
	{
		"jiaoshijie/undotree",
		---@module 'undotree.collector'
		---@type UndoTreeCollector.Opts
		opts = {
			-- your options
		},
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
}
return M
