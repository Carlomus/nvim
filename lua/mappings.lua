local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>q", ":bd<CR>", { desc = "Delete buffer" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })

map("n", "<leader>tn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>tr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- move lines and blocks
map("n", "<A-j>", ":m .+1<CR>==", { desc = "line ⇣ (swap with below)" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "line ⇡ (swap with above)" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "block ⇣" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "block ⇡" })

-- Duplicate line
map("n", "<C-a>", [[:normal! ggVG$<CR>]], { desc = "Visually select entire file and return" })
map("n", "<C-p>", "o<ESC>p", { desc = "paste on new line" })
map("n", "<leader>o", '"_ddP', { desc = "Overwrite line with last yanked or deleted line" })
map("n", "<leader>yaf", "v[{]}y", { desc = "Yank current fold" })

-- Toggle spell check
map("n", "<leader>ts", ":set spell!<CR>", { desc = "toggle spell" })

-- d goes to black hole
map({ "n", "v" }, "d", '"_d', { desc = "delete (black-hole)" })
map({ "n", "v" }, "<leader>d", "d", { desc = "delete and yank (default)" })

map({ "n", "x" }, "<leader>h", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- buffer navigation
map("n", "<S-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<C-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>bv", "<cmd>vsplit<CR>", { desc = "Move buffer to new vertical split" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

-- Comment
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })

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

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })
