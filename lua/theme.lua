-- lua/config/theme.lua
local M = {}

-- path that survives `:Lazy clean`
local theme_file = vim.fn.stdpath("data") .. "/last_colorscheme.txt"

function M.load()
	local ok, lines = pcall(vim.fn.readfile, theme_file)
	if ok and lines[1] and #lines[1] > 0 then
		pcall(vim.cmd.colorscheme, lines[1])
		vim.notify(lines[1])
	end
end

function M.autosave()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			local cs = vim.g.colors_name
			if cs then
				pcall(vim.fn.writefile, { cs }, theme_file)
			end
		end,
	})
end

return M
