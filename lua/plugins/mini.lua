local modules = {
	{ "mini.ai", nil },
	{ "mini.comment", nil },
	{ "mini.operators", nil },
	{ "mini.splitjoin", nil },
	-- { "mini.icons", nil },
	{ "mini.surround", "config.mini.surround" },
	{ "mini.hipatterns", "config.mini.hipatterns" },
	-- { "mini.git", nil },
	{ "mini.diff", "config.mini.diff" },
	-- { "mini.sessions", "config.mini.sessions" },
	-- { "mini.completion", nil},
	-- { "mini.snippets", nil},
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
