M = {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {
			PATH = "skip",
			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},
			max_concurrent_installers = 10,
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lspconfig").defaults()
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
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					local ls = require("luasnip")
					ls.config.set_config(opts)
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
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						-- enable inlay hints for this buffer
						rt.inlay_hints.enable()
						-- workspace symbol snippet helpers
						vim.keymap.set(
							"n",
							"<leader>rs",
							rt.workspace_symbol_query,
							{ buffer = bufnr }
						)
					end,
				},
			})
		end,
	},
}
return M
