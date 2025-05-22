M = {
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.quarto")
		end,
		ft = { "ipynb", "quarto", "markdown" },
	},
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		opts = {
			processor = "magick_cli",
			backend = "kitty", -- Kitty will provide the best experience, but you need a compatible terminal
			integrations = {}, -- do whatever you want with image.nvim's integrations
			max_width = 100, -- tweak to preference
			max_height = 12, -- ^
			max_height_window_percentage = math.huge, -- this is necessary for a good experience
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"benlubas/molten-nvim",
		-- version = "^2.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		ft = { "markdown", "quarto", "python" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			-- vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
			vim.g.molten_auto_open_html_in_browser = true
			vim.g.molten_tick_rate = 200
			vim.g.molten_use_border_highlights = true
			-- optional, I like wrapping. works for virt text and the output window
			vim.g.molten_wrap_output = true

			-- Output as virtual text. Allows outputs to always be shown, works with images, but can
			-- be buggy with longer images
			vim.g.molten_virt_text_output = true

			-- this will make it so the output shows up below the \`\`\` cell delimiter
			vim.g.molten_virt_lines_off_by_1 = true
		end,
		config = function()
			return require("config.molten")
		end,
	},
	-- {
	--   "goerz/jupytext.nvim",
	--   version = "0.2.0",
	--   lazy    = false,            -- ← load on startup
	--   opts    = {
	--     -- the two lines that call `require("jupytext")`
	--     filetype     = require("jupytext").get_filetype,
	--     new_template = require("jupytext").default_new_template(),
	--
	--     -- anything you actually want to customise
	--     format          = "markdown",
	--     sync_patterns   = { "*.md", "*.py", "*.jl", "*.R", "*.Rmd", "*.qmd" },
	--     autosync        = true,
	--     handle_url_schemes = true,
	--   },
	-- },
	{
		"goerz/jupytext.nvim",
		version = "0.2.0",
		event = {
			"BufReadPre *.ipynb",
			"BufNewFile *.ipynb",
			"BufReadPre *.md",
		},
		config = function()
			local jt = require("jupytext")
			jt.setup({
				format = "markdown",
				sync_patterns = { "*.md", "*.jl", "*.R", "*.Rmd", "*.qmd" },
				autosync = true,
				handle_url_schemes = true,
				filetype = jt.get_filetype,
				new_template = jt.default_new_template(),
			})
		end,
	},
}

return M
