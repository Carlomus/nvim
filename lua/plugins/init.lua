return {
	"nvim-lua/plenary.nvim",
	{
		"carlomus/VIper",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "python", "ipynb", "markdown" },
	},
	{
		"geg2102/nvim-jupyter-client",
		ft = { "ipynb" },
		opts = function()
			return require("configs.jupyter")
		end,
	},
	{
		"geg2102/nvim-python-repl",
		dependencies = "nvim-treesitter",
		ft = { "python", "lua", "scala" },
		opts = function()
			return require("configs.python-repl")
		end,
	},
	-- {
	-- 	"quarto-dev/quarto-nvim",
	-- 	dependencies = {
	-- 		"jmbuhr/otter.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("configs.quarto")
	-- 	end,
	-- 	ft = { "quarto", "markdown" },
	-- },
	-- {
	-- 	"3rd/image.nvim",
	-- 	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
	-- 	opts = {
	-- 		processor = "magick_cli",
	-- 		backend = "kitty", -- Kitty will provide the best experience, but you need a compatible terminal
	-- 		integrations = {}, -- do whatever you want with image.nvim's integrations
	-- 		max_width = 100, -- tweak to preference
	-- 		max_height = 12, -- ^
	-- 		max_height_window_percentage = math.huge, -- this is necessary for a good experience
	-- 		max_width_window_percentage = math.huge,
	-- 		window_overlap_clear_enabled = true,
	-- 		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 	},
	-- },
	-- {
	-- 	"benlubas/molten-nvim",
	-- 	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	-- 	dependencies = { "3rd/image.nvim" },
	-- 	build = ":UpdateRemotePlugins",
	-- 	init = function()
	-- 		vim.g.molten_image_provider = "image.nvim"
	-- 		-- vim.g.molten_output_win_max_height = 20
	-- 		vim.g.molten_auto_open_output = false
	-- 		vim.g.molten_auto_open_html_in_browser = true
	-- 		vim.g.molten_tick_rate = 200
	-- 		vim.g.molten_use_border_highlights = true
	-- 		-- optional, I like wrapping. works for virt text and the output window
	-- 		vim.g.molten_wrap_output = true
	--
	-- 		-- Output as virtual text. Allows outputs to always be shown, works with images, but can
	-- 		-- be buggy with longer images
	-- 		vim.g.molten_virt_text_output = true
	--
	-- 		-- this will make it so the output shows up below the \`\`\` cell delimiter
	-- 		vim.g.molten_virt_lines_off_by_1 = true
	-- 	end,
	-- 	config = function()
	-- 		return require("configs.molten")
	-- 	end,
	-- },
	-- {
	-- 	"GCBallesteros/jupytext.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("jupytext").setup({
	-- 			style = "markdown",
	-- 			output_extension = "md",
	-- 			force_ft = "markdown",
	-- 		})
	-- 	end,
	-- },
	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",
	"nvzone/menu",
	{ "nvzone/minty", cmd = { "Huefy", "Shades" } },

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},

	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
	},

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},

	-- formatting!
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("configs.conform")
		end,
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return require("configs.gitsigns")
		end,
	},

	-- lsp stuff
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = function()
			return require("configs.mason")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			require("configs.lspconfig").defaults()
		end,
	},

	-- load luasnips + cmp related in insert mode only
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
					require("luasnip").config.set_config(opts)
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
			return require("configs.cmp")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
