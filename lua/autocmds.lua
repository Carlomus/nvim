local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local o = vim.o

-- Start with blocks of code opened up
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ctx)
		local client = assert(vim.lsp.get_client_by_id(ctx.data.client_id))
		if
			client
			and client.supports_method
			and client:supports_method("textDocument/foldingRange")
		then
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
			o.foldlevel = 99
			o.foldlevelstart = 99
		end
	end,
})

-- Highlight yanked text ──────────────────────────────────
local yank_group = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		-- highlight for 150 ms using the IncSearch colors
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Restore cursor position when you reopen a file
autocmd("BufReadPost", {
	group = augroup("RestoreCursor", { clear = true }),
	pattern = "*",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lnum = mark[1]
		if lnum > 1 and lnum <= vim.api.nvim_buf_line_count(0) then
			vim.cmd('normal! g`"')
		end
	end,
})

--  Auto-create missing directories before saving a file
autocmd("BufWritePre", {
	group = augroup("AutoMkdir", { clear = true }),
	pattern = "*",
	callback = function(event)
		local file = event.match
		local dir = vim.fn.fnamemodify(file, ":p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Reload a buffer automatically when the file changes on disk
autocmd({ "FocusGained", "BufEnter" }, {
	group = augroup("AutoReload", { clear = true }),
	pattern = "*",
	command = "checktime",
})

-- Close certain ‘utility’ windows quickly with just <q>
autocmd("FileType", {
	group = augroup("QuickClose", { clear = true }),
	pattern = { "help", "qf", "lspinfo" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
	end,
})

-- Re-enable line numbers when returning to normal buffers
local grp = vim.api.nvim_create_augroup("ForceNumberOnNormal", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = grp,
	callback = function()
		local bt = vim.bo.buftype
		if bt == "" or bt == "acwrite" then
			vim.wo.number = true
			-- vim.wo.relativenumber = vim.wo.relativenumber or false
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = grp,
	pattern = { "lazy", "snacks_picker", "TelescopePrompt", "help", "qf" },
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})
