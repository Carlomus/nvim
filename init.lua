if vim.loader then
	vim.loader.enable()
end

vim.g.mapleader = " "

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

require("mercury.mercury").setup({})

require("options")
require("autocmds")
require("mappings")
require("plug_mappings")

local theme = require("theme")
theme.load()

-- require("ipynb_plugin.ipyn_lens").setup({})
