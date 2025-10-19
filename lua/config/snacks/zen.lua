-- plugins/snacks.lua
return {
	-----------------------------------------------------------------------
	-- Toggle other UI bits on/off while Zen is active.
	-- These are Snacks.toggle IDs. Their state is restored when Zen closes.
	-----------------------------------------------------------------------
	toggles = {
		dim = true, -- use Snacks.dim to fade code outside your focus
		git_signs = false, -- hide gitsigns while zenning
		mini_diff_signs = true, -- hide mini.diff signs if you use it
		diagnostics = false, -- (optional) hide virtual text & signs
		-- inlay_hints = false,  -- uncomment if you use LSP inlay hints
	},

	-----------------------------------------------------------------------
	-- Show/hide global UI elements (requires global statusline to show).
	-----------------------------------------------------------------------
	show = {
		statusline = true,
		tabline = false,
	},

	-----------------------------------------------------------------------
	-- Window look & feel (uses the built-in "zen" style as a base).
	-----------------------------------------------------------------------
	win = {
		style = "zen", -- use the pre-defined 'zen' style
		-- You can override parts of the style here if you want:
		-- width = 120,          -- fixed content width (0 = full)
		-- height = 0,           -- 0 = full height
		-- backdrop = { transparent = true, blend = 40 },
	},

	-----------------------------------------------------------------------
	-- Called when the Zen window opens. Great for per-buffer tweaks.
	-- `win` is a Snacks.win handle (wrapper around a floating/scratch win).
	-----------------------------------------------------------------------
	on_open = function(win)
		-- Example: soften distractions without changing your global options.
	end,

	-----------------------------------------------------------------------
	-- Called when the Zen window closes. Restore anything you changed.
	-----------------------------------------------------------------------
	on_close = function(win)
		if win._old_ccol ~= nil then
			vim.wo.colorcolumn = win._old_ccol
			win._old_ccol = nil
		end
	end,

	-----------------------------------------------------------------------
	-- A lighter-weight “maximize current window” mode.
	-- Good when you want the space but not full zen toggles.
	-----------------------------------------------------------------------
	zoom = {
		toggles = {}, -- keep other toggles as-is
		show = { statusline = true, tabline = true }, -- keep UI visible
		win = {
			backdrop = false, -- no dim backdrop
			width = 0, -- full width
			-- height = 0, -- full height (default)
		},
	},
}
