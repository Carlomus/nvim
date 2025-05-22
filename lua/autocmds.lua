local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Start with blocks of code opened up
autocmd({ "BufReadPost", "FileReadPost" }, {
	group = augroup("OpenFolds", { clear = true }),
	pattern = "*",
	command = "normal! zR",
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

-- lua/autocmds/molten_init.lua
local grp = vim.api.nvim_create_augroup("MoltenAutostart", { clear = false })

vim.api.nvim_create_autocmd("FileType", {
	group = grp,
	pattern = { "markdown", "quarto", "ipynb", "md" },
	callback = function()
		if vim.fn.exists(":MoltenInit") == 0 then
			require("lazy").load({ plugins = { "molten-nvim" } })
		end
		if not (#vim.fn.MoltenRunningKernels({ true }) > 0) then
			vim.cmd("MoltenInit base") -- use the 'base' conda env
		end
		pcall(vim.api.nvim_command, "silent! MoltenImportOutput")
	end,
})

-- 2. export inline outputs back into the .ipynb every save
vim.api.nvim_create_autocmd("BufWritePost", {
	group = grp,
	pattern = "*.ipynb",
	command = "silent! MoltenExportOutput!",
})

-- 3. optional: detach gitsigns for raw .ipynb buffers (diff noise)
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*.ipynb",
--   callback = function()
--     local gs_ok, gs = pcall(require, "gitsigns")
--     if gs_ok then gs.detach() end
--   end,
-- })

-- lua/autocmds/quarto_activate.lua
local aug = vim.api.nvim_create_augroup("QuartoAutoActivate", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadCmd", "BufReadPost" }, {
	group = aug,
	pattern = { "*.ipynb", "*.md", "*.qmd" },
	callback = function()
		if vim.fn.exists(":QuartoActivate") == 0 then
			require("lazy").load({ plugins = { "quarto-nvim" } })
		end

		-- 2. defer one tick so Quarto can finish defining commands
		vim.schedule(function()
			if vim.fn.exists(":QuartoActivate") == 2 then
				vim.cmd("silent! QuartoActivate")
			end
		end)
	end,
})

-- lua/autocmds/cursor_after_frontmatter.lua
local jump_grp = vim.api.nvim_create_augroup("JumpAfterFrontMatter", { clear = false })

vim.api.nvim_create_autocmd({ "BufReadCmd", "BufReadPost" }, {
	group = jump_grp,
	pattern = { "*.ipynb", "*.md", "*.qmd" },
	callback = function()
		if vim.fn.getline(1):match("^%-%-%-%s*$") then
			-- line-by-line scan for the *next* --- that closes YAML front-matter
			local last = vim.fn.line("$")
			local lnum = 2
			while lnum <= last and not vim.fn.getline(lnum):match("^%-%-%-%s*$") do
				lnum = lnum + 1
			end
			if lnum <= last then
				-- skip the closing --- and blank lines that follow
				repeat
					lnum = lnum + 1
				until lnum > last or not vim.fn.getline(lnum):match("^%s*$")
				vim.api.nvim_win_set_cursor(0, { lnum, 0 })
			end
		end
	end,
})
