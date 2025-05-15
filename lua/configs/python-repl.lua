vim.keymap.set("n", "<leader>js", function()
	require("nvim-python-repl").send_statement_definition()
end, { desc = "Send semantic unit to REPL" })

vim.keymap.set("v", "<leader>jv", function()
	require("nvim-python-repl").send_visual_to_repl()
end, { desc = "Send visual selection to REPL" })

vim.keymap.set("n", "<leader>jb", function()
	require("nvim-python-repl").send_buffer_to_repl()
end, { desc = "Send entire buffer to REPL" })

-- vim.keymap.set("n", "<leader>jS", function()
-- 	require("nvim-python-repl").toggle_execute()
-- end, { desc = "Automatically execute command in REPL after sent" })
--
-- vim.keymap.set("n", "<leader>jv", function()
-- 	require("nvim-python-repl").toggle_vertical()
-- end, { desc = "Create REPL in vertical or horizontal split" })

vim.keymap.set("n", "<leader>jt", function()
	require("nvim-python-repl").open_repl()
end, { desc = "Opens the REPL in a window split" })

vim.keymap.set("n", "<leader>jr", function()
	require("nvim-python-repl").send_current_cell_to_repl()
end, { desc = "Sends the cell under cursor to repl" })

M = {
	execute_on_send = true,
	vsplit = true,
}

return M
