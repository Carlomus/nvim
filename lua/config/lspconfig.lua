local virtual_text_enabled = false
local map = vim.keymap.set

local M = {}

-- export on_attach & capabilities
M.on_attach = function(client, bufnr)
	map("n", "<leader>td", function()
		virtual_text_enabled = not virtual_text_enabled
		vim.diagnostic.config({
			virtual_text = virtual_text_enabled,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
		local msg = virtual_text_enabled and "Virtual text ON" or "Virtual text OFF"
		vim.notify(msg, vim.log.levels.INFO, { title = "Diagnostics" })
	end, { desc = "Toggle diagnostics virtual text" })

	-- attach navic if supported
	local ok, navic = pcall(require, "nvim-navic")
	if ok and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- M.capabilities.textDocument.completion.completionItem = {
-- 	documentationFormat = { "markdown", "plaintext" },
-- 	snippetSupport = true,
-- 	preselectSupport = true,
-- 	insertReplaceSupport = true,
-- 	labelDetailsSupport = true,
-- 	deprecatedSupport = true,
-- 	commitCharactersSupport = true,
-- 	tagSupport = { valueSet = { 1 } },
-- 	resolveSupport = {
-- 		properties = {
-- 			"documentation",
-- 			"detail",
-- 			"additionalTextEdits",
-- 		},
-- 	},
-- }

M.defaults = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local servers = require("others.servers")

	for _, server in ipairs(servers) do
		vim.lsp.config(server, {
			on_attach = M.on_attach,
			capabilities = capabilities,
		})
		vim.lsp.enable(server)
	end

	vim.lsp.config("pyright", {
		on_attach = M.on_attach,
		capabilities = capabilities,
		root_markers = {
			-- "pyproject.toml",
			-- "setup.py",
			-- "setup.cfg",
			-- "requirements.txt",
			-- "Pipfile",
			-- "pyrightconfig.json",
			".git",
		},
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off",
				},
			},
		},
	})
	vim.lsp.enable("pyright")

	-- Lua-specific LSP setup with settings
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				workspace = {
					library = {
						vim.api.nvim_get_runtime_file("", true),
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					},
					checkThirdParty = false,
				},
				diagnostics = {
					globals = { "vim" },
				},
				telemetry = { enable = false },
			},
		},
	})
	vim.lsp.enable("lua_ls")

	-- Clangd + CUDA
	vim.lsp.config("clangd", {
		on_attach = M.on_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			-- helps clangd accept flags coming from nvcc / toolchains
			"--query-driver=/usr/bin/g++,/usr/local/cuda/bin/nvcc",
		},
	})
	vim.lsp.enable("clangd")
end

return M
