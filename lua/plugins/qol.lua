local M = {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.conform")
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "python" },
				injections = {
					python = {
						enabled = true,
						query = [[
        (
          (expression_statement (string (string_content) @injection.content))
          (#in_notebook_markdown_block? @injection.content)
          (#set! injection.language "markdown")
          (#set! injection.combined)  ; may produce a list -> handled by predicate
        )
      ]],
					},
				},
			})
		end,
	},
	-- {
	-- 	"stevearc/oil.nvim",
	-- 	---@module 'oil'
	-- 	---@type oil.SetupOpts
	-- 	opts = {},
	-- 	-- Optional dependencies
	-- 	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- 	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	-- 	lazy = false,
	-- },
}
return M
