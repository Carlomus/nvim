local opt = vim.opt
local o = vim.o

-------------------------------------- options ------------------------------------------
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldlevelstart = 99

o.laststatus = 3
o.showtabline = 2
o.showmode = false
opt.scrolloff = 30
o.cmdheight = 0

-- Highlight the number/line cursor is on
o.cursorline = true
o.cursorlineopt = "number,line"

-- Indenting
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

o.winbar = ""
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 3
o.ruler = true

opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- get rid of swapfiles, they tend to be annoying
o.swapfile = false
-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- line length Highlight
o.colorcolumn = "88"

-- Don't continue comments
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep)
	.. delim
	.. vim.env.PATH
