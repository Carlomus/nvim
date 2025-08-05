M = {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.lspconfig").defaults()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = {
					history = true,
					update_events = "TextChanged,TextChangedI",
					delete_check_events = "TextChanged,InsertLeave",
					region_check_events = "CursorHold,InsertEnter",
				},
				config = function(_, opts)
					require("luasnip").setup(opts)
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},

			-- cmp sources plugins
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			return require("config.cmp")
		end,
	},
}
return M
