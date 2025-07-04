-- lua/config/mini/base16.lua
local helpers = require("others.helpers")

local function hsl(h, s, l)
	return h, s, l
end

local palette = {
	-- Background shades
	base00 = helpers.hsl_to_hex(hsl(220, 13, 18)), -- bg
	base01 = helpers.hsl_to_hex(hsl(220, 13, 24)), -- bg_lighter
	base02 = helpers.hsl_to_hex(hsl(220, 13, 30)), -- selection bg / subtle
	base03 = helpers.hsl_to_hex(hsl(220, 13, 50)), -- comments / dim

	-- Foreground shades
	base04 = helpers.hsl_to_hex(hsl(220, 13, 70)), -- fg_dimmer
	base05 = helpers.hsl_to_hex(hsl(220, 13, 85)), -- fg
	base06 = helpers.hsl_to_hex(hsl(220, 13, 92)), -- fg_brighter
	base07 = helpers.hsl_to_hex(hsl(220, 13, 98)), -- near white

	-- Accents
	base08 = helpers.hsl_to_hex(hsl(0, 70, 60)), -- errors
	base09 = helpers.hsl_to_hex(hsl(30, 70, 60)), -- warnings
	base0A = helpers.hsl_to_hex(hsl(45, 90, 60)), -- constants
	base0B = helpers.hsl_to_hex(hsl(120, 60, 50)), -- success, strings
	base0C = helpers.hsl_to_hex(hsl(180, 60, 50)), -- specials
	base0D = helpers.hsl_to_hex(hsl(220, 70, 60)), -- keywords
	base0E = helpers.hsl_to_hex(hsl(280, 60, 65)), -- functions
	base0F = helpers.hsl_to_hex(hsl(330, 60, 60)), -- builtins
}

return {
	palette = palette,
	use_cterm = true,
	plugins = { default = true },
}
