return {
	options = {
		theme = "auto",
		icons_enabled = true,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
		},
		lualine_c = {
			{ "filename", path = 1 },
			{
				function()
					local ok, navic = pcall(require, "nvim-navic")
					if ok and navic.is_available() then
						return navic.get_location()
					end
					return ""
				end,
			},
		},
		lualine_x = {
			"filetype",
			function()
				local conda_env = vim.env.CONDA_DEFAULT_ENV
				if conda_env then
					return ":  " .. conda_env
				end

				local venv = vim.env.VIRTUAL_ENV
				if venv then
					return ":  " .. vim.fn.fnamemodify(venv, ":t")
				end

				return ":  System" -- nothing active
			end,
			"lsp_status",
		},
		lualine_y = { "diff", "diagnostics", "progress" },
		lualine_z = { "fileformat", "location" },
	},
}
