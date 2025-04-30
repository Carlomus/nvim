local options = {
	base46 = {
		theme = "aylin",
		hl_add = {},
		hl_override = {
			-- nvim-tree Git indicators
			NvimTreeGitDirty = { fg = "yellow" }, -- modified
			NvimTreeGitStaged = { fg = "green" }, -- staged
			NvimTreeGitNew = { fg = "cyan" }, -- untracked
			NvimTreeGitDeleted = { fg = "red" }, -- deleted
			NvimTreeGitMerge = { fg = "purple" }, -- conflict
			NvimTreeGitRenamed = { fg = "orange" }, -- renamed
			NvimTreeGitIgnored = { fg = "grey_5" }, -- ignored
		},
		integrations = {},
		changed_themes = {},
		transparency = false,
		theme_toggle = { "aylin", "one_light" },
	},

	ui = {
		cmp = {
			icons_left = false, -- only for non-atom styles!
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
			abbr_maxwidth = 60,
			-- for tailwind, css lsp etc
			format_colors = { lsp = true, icon = "󱓻" },
		},

		telescope = { style = "borderless" }, -- borderless / bordered

		statusline = {
			enabled = true,
			theme = "default", -- default/vscode/vscode_colored/minimal
			-- default/round/block/arrow separators work only for default statusline theme
			-- round and block will work for minimal theme only
			separator_style = "default",
			order = nil,
			modules = nil,
		}, --    (defaults to bearded-arc)

		-- lazyload it when there are 1+ buffers
		tabufline = {
			enabled = true,
			lazyload = false,
			order = { "treeOffset", "buffers", "tabs", "btns" },
			modules = nil,
			bufwidth = 21,
		},
	},

	nvdash = {
		load_on_startup = true,
		header = {
			"                            ",
			"     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
			"   ▄▀███▄     ▄██ █████▀    ",
			"   ██▄▀███▄   ███           ",
			"   ███  ▀███▄ ███           ",
			"   ███    ▀██ ███           ",
			"   ███      ▀ ███           ",
			"   ▀██ █████▄▀█▀▄██████▄    ",
			"     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
			"                            ",
			"     Powered By  eovim    ",
			"                            ",
		},

		buttons = {
			{ txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
			{ txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
			{ txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
			{ txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
			{ txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

			{
				txt = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime) .. " ms"
					return "  Loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
				end,
				hl = "NvDashFooter",
				no_gap = true,
			},

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
		},
	},

	term = {
		base46_colors = true,
		winopts = { number = false, relativenumber = false },
		sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
		float = {
			relative = "editor",
			row = 0.3,
			col = 0.25,
			width = 0.5,
			height = 0.4,
			border = "single",
		},
	},

	lsp = { signature = true },

	cheatsheet = {
		theme = "grid", -- simple/grid
		excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
	},

	mason = {
		pkgs = {
			-- ───── Lua ─────
			"lua-language-server", -- LSP
			"stylua", -- formatter

			-- ───── HTML / CSS  ─────
			"html-lsp", -- LSP
			"css-lsp", -- LSP   (a.k.a. cssls)
			"emmet-ls", -- optional: expander in JSX/HTML
			"prettierd", -- fast daemon-version of Prettier

			-- ───── Python ─────
			"pyright", -- LSP
			"ruff", -- linter / rules / fixes
			"black", -- formatter
			"debugpy", -- DAP adapter (if you install nvim-dap)

			-- ───── Rust ─────
			"rust-analyzer", -- LSP
			"rustfmt", -- formatter (runs via cargo)
			"codelldb", -- DAP adapter (for nvim-dap)
			"taplo", -- TOML LSP (useful because Rust = Cargo.toml)

			-- ───── Common utilities (optional but handy) ─────
			"json-lsp", -- JSON schemas & completion
			"yaml-language-server", -- YAML
			"bash-language-server", -- Bash scripts
			"shfmt", -- Bash formatter
			"shellcheck", -- Bash linter
		},
		skip = {},
	},

	colorify = {
		enabled = true,
		mode = "virtual", -- fg, bg, virtual
		virt_text = "󱓻 ",
		highlight = { hex = true, lspvars = true },
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
