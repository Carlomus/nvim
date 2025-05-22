-- Full list of tools to install via Mason
local lsps = {
	"lua_ls",
	"html",
	"cssls",
	"pyright",
	"rust_analyzer",
	"taplo", -- TOML LSP
	"jsonls", -- JSON
	"bashls", -- Bash
	"yamlls", -- YAML
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

local servers = vim.iter({ lsps, formatters, daps, linters, others }):flatten():totable()

-- MasonInstallAll command
vim.api.nvim_create_user_command("MasonInstallAll", function()
	vim.cmd("MasonInstall " .. table.concat(servers, " "))
end, { desc = "Install every LSP/tool in the servers table with Mason" })

-- Export only LSPs for use with `lspconfig`
return lsps
