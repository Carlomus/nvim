-- 1) Which “package names” Mason should install:
local mason_packages = {
	"lua-language-server",
	"html-lsp",
	"pyright",
	"rust-analyzer",
	"clangd",
	"taplo",
	"json-lsp", -- or "json-lsp" if your Mason registry says so
	"bash-language-server", -- or "bashls" if that’s what your Mason registry shows
	"yaml-language-server", -- or "yamlls"
}

local formatters = {
	"stylua",
	"black",
	"rustfmt",
	"shfmt",
}

local daps = {
	"debugpy",
	"codelldb",
}

local linters = {
	"ruff",
	"shellcheck",
}

local others = {
	"emmet-ls",
	"prettierd",
}

-- Combine everything so that `:MasonInstallAll` will install all tools
local all_packages =
	vim.iter({ mason_packages, formatters, daps, linters, others }):flatten():totable()

vim.api.nvim_create_user_command("MasonInstallAll", function()
	-- This will read: :MasonInstall <all_packages separated by spaces>
	vim.cmd("MasonInstall " .. table.concat(all_packages, " "))
end, { desc = "Install every LSP/tool in the all_packages list with Mason" })

-- 2) Which “server names” LSPConfig actually needs to call .setup() on:
--    These must match lspconfig’s `:help lspconfig-servers` entries.
local lspconfig_servers = {
	-- "lua_ls", --Handled separately
	"html",
	-- "pyright", -- handled separately
	"rust_analyzer",
	"clangd",
	"taplo",
	"jsonls",
	"bashls",
	"yamlls",
}

return lspconfig_servers
