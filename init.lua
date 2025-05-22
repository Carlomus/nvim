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

local servers = {
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

	--;w ───── Rust ─────
	"rust-analyzer", -- LSP
	"rustfmt", -- formatter (runs via cargo)
	"codelldb", -- DAP adapter (for nvim-dap)
	"taplo", -- TOML LSP (useful because Rust = Cargo.toml)
	-- "starpls"

	-- ───── Common utilities (optional but handy) ─────
	"json-lsp", -- JSON schemas & completion
	"yaml-language-server", -- YAML
	"bash-language-server", -- Bash scripts
	"shfmt", -- Bash formatter
	"shellcheck", -- Bash linter
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
	-- map lspconfig server → Mason package
	-- tell Mason to install them all in one shot
	-- (quote the args if you ever have spaces in a package name)
	vim.cmd("MasonInstall " .. table.concat(servers, " "))
end, { desc = "Install every LSP/tool in the servers table with Mason" })
