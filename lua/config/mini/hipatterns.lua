local hipatterns = require("mini.hipatterns")
local helpers = require("others.helpers")

return {
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),

		rgba_color = {
			pattern = "rgba?%(%s*%d+%s*,%s*%d+%s*,%s*%d+%s*,?%s*[0-9.]*%s*%)",
			group = function(_, match)
				local r, g, b = match:match("rgba?%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
				if not r then
					return nil
				end
				local hex = helpers.rgba_to_hex(tonumber(r), tonumber(g), tonumber(b))
				return hipatterns.compute_hex_color_group(hex, "bg")
			end,
		},

		hsl_color = {
			pattern = "hsla?%(%s*%d+%s*,%s*%d+%%?%s*,%s*%d+%%?%s*,?%s*[0-9.]*%s*%)",
			group = function(_, match)
				local h, s, l = match:match("hsla?%(%s*(%d+)%s*,%s*(%d+)%%?%s*,%s*(%d+)%%?")
				if not h then
					return nil
				end
				local hex = helpers.hsl_to_hex(tonumber(h), tonumber(s), tonumber(l))
				return hipatterns.compute_hex_color_group(hex, "bg")
			end,
		},
	},
}
