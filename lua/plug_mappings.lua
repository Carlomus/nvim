local map = vim.keymap.set

-- buffer navigation
map("n", "<S-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<C-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })

map({ "n", "x" }, "<leader>h", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
