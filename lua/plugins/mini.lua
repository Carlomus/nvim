local modules = {
	{ "mini.ai", nil },
	{ "mini.align", nil },
	{ "mini.comment", nil },
	-- "mini.completion",
	{ "mini.keymap", nil },
	-- "mini.move",
	{ "mini.operators", nil },
	{ "mini.pairs", nil },
	-- "mini.snippets",
	{ "mini.splitjoin", nil },
	{ "mini.surround", "config.mini.surround" },

	-- -- ▶ General workflow
	-- "mini.basics",
	-- "mini.bracketed",
	-- "mini.bufremove",
	-- "mini.clue",
	-- "mini.deps",
	-- "mini.diff",
	-- "mini.extra",
	-- "mini.files",
	-- "mini.git",
	-- "mini.jump",
	-- "mini.jump2d",
	-- "mini.misc",
	-- "mini.pick",
	-- "mini.sessions",
	-- "mini.visits",

	-- -- ▶ Appearance
	-- "mini.animate",
	-- { "mini.base16", "config.mini.base16" },
	-- "mini.colors",
	-- "mini.cursorword",
	{ "mini.hipatterns", "config.mini.hipatterns" },
	-- "mini.hues",
	-- "mini.icons",
	-- "mini.indentscope",
	-- "mini.map",
	-- { "mini.notify", nil },
	-- "mini.starter",
	-- "mini.statusline",
	-- "mini.tabline",
	-- "mini.trailspace",

	-- -- ▶ Other utilities
	-- "mini.doc",
	-- "mini.fuzzy",
	-- "mini.test",
}

return {
	"echasnovski/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		for _, spec in ipairs(modules) do
			local name, cfg = spec[1], spec[2]
			local ok, plugin = pcall(require, name)
			if not ok then
				vim.notify("mini.nvim loader: cannot require '" .. name .. "'", vim.log.levels.WARN)
			elseif plugin.setup then
				local opts = cfg and require(cfg) or nil
				plugin.setup(opts)
			end
		end
	end,
}
