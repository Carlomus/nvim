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
