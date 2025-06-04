--  Spy on every change to 'foldlevel'
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "foldlevel",
	callback = function()
		local src = debug.getinfo(2, "S") -- caller of :set
		vim.notify(
			("foldlevel → %s   (%s:%d)"):format(
				vim.v.option_new,
				src.short_src or "?",
				src.linedefined or 0
			)
		)
	end,
})

if vim.loader then
	vim.loader.enable()
end

vim.g.mapleader = " "
vim.g.python3_host_prog = vim.fn.exepath("python3")

require("filetypes")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require("config.lazy")

require("lazy").setup({
	{ import = "plugins" },
}, lazy_config)

require("options")
require("autocmds")
require("mappings")
require("servers")

local theme = require("theme")
theme.autosave()
theme.load()
