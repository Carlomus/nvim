local modules = {
	"mini.ai",
	"mini.align",
	"mini.comment",
	-- "mini.completion",
	"mini.keymap",
	-- "mini.move",
	"mini.operators",
	"mini.pairs",
	-- "mini.snippets",
	"mini.splitjoin",
	"mini.surround",

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
	-- "mini.base16",
	-- "mini.colors",
	-- "mini.cursorword",
	-- "mini.hipatterns",
	-- "mini.hues",
	-- "mini.icons",
	-- "mini.indentscope",
	-- "mini.map",
	-- "mini.notify",
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
		for _, m in ipairs(modules) do
			require(m).setup()
		end
	end,
}
