local virtual_text_enabled = true
local map = vim.keymap.set

local file_ops = require("lsp-file-operations")
file_ops.setup()

local M = {}

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end
	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
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
	-- map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.capabilities = vim.tbl_deep_extend("force", M.capabilities, file_ops.default_capabilities())

M.defaults = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			M.on_attach(client, args.buf)
		end,
	})
	local lua_lsp_settings = {
		Lua = {
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/luv/library",
				},
			},
		},
	}

	local lspconfig = require("lspconfig")
	local servers = require("servers")

	for _, server in ipairs(servers) do
		lspconfig[server].setup({
			on_attach = M.on_attach,
			capabilities = M.capabilities,
			on_init = M.on_init,
		})
	end

	-- Lua-specific LSP setup with settings
	lspconfig.lua_ls.setup({
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			Lua = {
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					},
					checkThirdParty = false,
				},
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
end

return M
