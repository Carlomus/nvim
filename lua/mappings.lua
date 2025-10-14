local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<leader>q", ":bd<CR>", { desc = "Delete buffer" })

-- map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
-- map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<leader>tn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>tr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- move lines and blocks
map("n", "<A-j>", ":m .+1<CR>==", { desc = "line ⇣" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "line ⇡" })
map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "block ⇣" })
map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "block ⇡" })

-- Toggle spell check
map("n", "<leader>ts", ":set spell!<CR>", { desc = "toggle spell" })

-- O and o do not auto go into insert mode
map("n", "o", "o<Esc>", { noremap = true, silent = true })
map("n", "O", "O<Esc>", { noremap = true, silent = true })

-- Make <leader>y a "use system clipboard" prefix
map(
	{ "n", "o" },
	"<leader>y",
	'"+',
	{ remap = true, silent = true, desc = "system clipboard prefix" }
)
map("x", "<leader>y", '"+y', { silent = true, desc = "yank selection → system clipboard" })
map("n", "<leader>Y", '"+Y', { silent = true, desc = "Yank to EOL → system clipboard" })

-- Disable arrow keys in normal and insert mode
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")

map({ "n", "x" }, "gy", [[:%y+<CR>]], { desc = "yank file to system clipboard", silent = true })
