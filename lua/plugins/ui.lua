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
					always_show_bufferline = false,
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
		"christopher-francisco/tmux-status.nvim",
		lazy = false, -- lualine depends on it anyway
		config = function()
			local function hex(n)
				return n and string.format("#%06x", n) or nil
			end

			local function get_bg(name)
				local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
				if not ok or not hl then
					return nil
				end
				return hex(hl.bg)
			end

			local function status_bg()
				-- Prefer lualine section bg if present; fallback to StatusLine.
				return get_bg("lualine_c_normal") or get_bg("StatusLine") or "NONE"
			end

			-- Use your existing tmux-status fg colors, but force bg = statusline bg
			local function apply_tmux_status_highlights()
				local bg = status_bg()

				local colors = {
					window_active = { fg = "#e69875", bg = bg },
					window_inactive = { fg = "#859289", bg = bg },
					window_inactive_recent = { fg = "#3f5865", bg = bg },
					session = { fg = "#a7c080", bg = bg },
					datetime = { fg = "#7a8478", bg = bg },
					battery = { fg = "#7a8478", bg = bg },
				}

				for name, value in pairs(colors) do
					vim.api.nvim_set_hl(0, "tmux_status_" .. name, {
						fg = value.fg,
						bg = value.bg,
					})
				end
			end

			-- Normal plugin setup (icons, manage_tmux_status, etc.)
			require("tmux-status").setup({
				-- you can still override other options here if you want
				-- manage_tmux_status = true,
			})

			-- Apply once now (after plugin loads)
			apply_tmux_status_highlights()

			-- Re-apply whenever colorscheme changes (theme.load() triggers ColorScheme)
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- defer 1 tick so lualine/theme highlight groups exist
					vim.schedule(apply_tmux_status_highlights)
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"christopher-francisco/tmux-status.nvim",
		},
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
				-- injections = {
				-- 	python = {
				-- 		enabled = true,
				-- 		query = [[
				--     (
				--       (expression_statement (string (string_content) @injection.content))
				--       (#in_notebook_markdown_block? @injection.content)
				--       (#set! injection.language "markdown")
				--       (#set! injection.combined)  ; may produce a list -> handled by predicate
				--     )
				--   ]],
				-- 	},
				-- },
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
