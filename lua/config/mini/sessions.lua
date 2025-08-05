return {
	autoread = false, -- Don't auto-read on startup
	autowrite = true, -- Auto-write when quitting or switching
	directory = vim.fn.stdpath("data") .. "/sessions", -- Default global dir
	file = "default.vim",
	force = {
		read = false,
		write = true,
		delete = false,
	},
	verbose = {
		read = false,
		write = false,
		delete = true,
	},
}
