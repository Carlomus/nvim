vim.keymap.set(
	"n",
	"<leader>je",
	":MoltenEvaluateOperator<CR>",
	{ desc = "evaluate operator", silent = true }
)

local function toggle_molten_output()
	-- Try to hide; if that errors (not open), then open.
	if not pcall(vim.api.nvim_command, "MoltenHideOutput") then
		pcall(vim.api.nvim_command, "MoltenEnterOutput")
	end
end

vim.keymap.set(
	"n",
	"<leader>jo",
	toggle_molten_output,
	{ desc = "Molten toggle output", silent = true }
)

vim.keymap.set(
	"n",
	"<leader>ji",
	":noautocmd MoltenEnterOutput<CR>",
	{ desc = "inspect output window", silent = true }
)
vim.keymap.set(
	"n",
	"<leader>jw",
	":MoltenHideOutput<CR>",
	{ desc = "close output window", silent = true }
)

vim.keymap.set(
	"n",
	"<leader>jR",
	":MoltenReevaluateCell<CR>",
	{ desc = "re-eval cell", silent = true }
)

vim.keymap.set(
	"n",
	"<localleader>jd",
	":MoltenDelete<CR>",
	{ desc = "delete Molten cell", silent = true }
)

-- if you work with html outputs:
vim.keymap.set(
	"n",
	"<leader>jb",
	":MoltenOpenInBrowser<CR>",
	{ desc = "open output in browser", silent = true }
)

vim.keymap.set("n", "<leader>jI", ":MoltenInit<CR>")

-- local runner = require("quarto.runner")

local ok, runner = pcall(require, "quarto.runner")

if not ok then
	print("NO RUNNER FOR QUARTO")
end

vim.keymap.set("n", "<leader>jr", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set(
	"n",
	"<localleader>ja",
	runner.run_above,
	{ desc = "run cell and above", silent = true }
)
vim.keymap.set("n", "<leader>ja", runner.run_all, { desc = "run all cells", silent = true })

vim.keymap.set("n", "<leader>RA", function()
	runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })
