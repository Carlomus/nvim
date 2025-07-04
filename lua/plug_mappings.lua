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

-- nvimtree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map(
	"n",
	"<leader>fh",
	"<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ desc = "telescope find in current buffer" }
)
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "telescope find all files" }
)
map("n", "<leader>th", function()
	require("telescope.builtin").colorscheme({
		enable_preview = true,
		layout_strategy = "horizontal",
		layout_config = {
			height = 0.20, -- 20 % tall
			width = 0.30, -- 30 % wide
			preview_width = 0, -- % of the picker width
		},
	})
end, { desc = "Pick theme" })

-- terminal
map("t", "<A-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
