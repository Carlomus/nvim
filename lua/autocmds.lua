local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
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
	pattern = { "help", "qf", "lspinfo", "spectre_panel", "toggleterm" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
	end,
})

--  Start in insert mode automatically for terminal buffers
autocmd("TermOpen", {
	group = augroup("TermInsert", { clear = true }),
	pattern = "*",
	command = "startinsert",
})
