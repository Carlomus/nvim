M = {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = { "BufNew", "BufEnter" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					separator_style = "thick",
					show_buffer_close_icons = false,
					show_close_icon = false,
					enforce_regular_tabs = true,
					always_show_bufferline = true,
					numbers = "ordinal",
					indicator = {
						style = "underline",
					},
				},
			})
		end,
	},
	{
		-- lualine breadcrumbs
		"SmiteshP/nvim-navic",
		config = function()
			local config = require("config.navic")
			require("nvim-navic").setup(config)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
		lazy = false,
		config = function()
			local config = require("config.lualine")
			require("lualine").setup(config)
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = { "Neotree" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle reveal left<cr>",
				desc = "File Explorer (neo-tree)",
			},
			{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			default_component_configs = {
				indent = { with_expanders = true },
				-- git_status = { symbols = { added = "A", modified = "M", deleted = "D", renamed = "R" } },
			},
			window = {
				width = 30,
				mappings = {
					-- sensible defaults are already there: <cr>/o=open, a=add, r=rename, d=delete, m=move, y=copy
					["<esc>"] = "close_window",
				},
			},
		},
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
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock
		opts = {
			processor = "magick_cli",
		},
	},
}

return M
