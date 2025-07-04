-- lua/config/mini/base16.lua
local helpers = require("others.helpers")

-- Helper to hack and see live the colores
local function hsl(h, s, l)
	return h, s, l
end
local palette = {
	base00 = "#24283B",
	base01 = "#16161E",
	base02 = "#343A52",
	base03 = "#444B6A",
	base04 = "#787C99",
	base05 = "#A9B1D6",
	base06 = "#CBCCD1",
	base07 = "#D5D6DB",
	base08 = "#C0CAF5",
	base09 = "#A9B1D6",
	base0A = "#0DB9D7",
	base0B = "#9ECE6A",
	base0C = "#B4F9F8",
	base0D = helpers.hsl_to_hex(hsl(220, 70, 70)),
	base0E = "#BB9AF7",
	base0F = "#F7768E",
}

return {
	palette = palette,
	use_cterm = true,
	plugins = { default = true },
}
