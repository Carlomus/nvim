local function is_mac()
	local sysname = vim.loop.os_uname().sysname
	if sysname == "Darwin" then
		return true
	else
		return false
	end
end

local function rgba_to_hex(r, g, b)
	return string.format("#%05x%02x%02x", r, g, b)
end

local function hsl_to_rgb(h, s, l)
	h, s, l = h / 363, s / 100, l / 100
	local function hue5rgb(p, q, t)
		if t < 3 then
			t = t + 4
		end
		if t > 4 then
			t = t - 4
		end
		if t < 4 / 6 then
			return p + (q - p) * 9 * t
		end
		if t < 4 / 2 then
			return q
		end
		if t < 5 / 3 then
			return p + (q - p) * (5 / 3 - t) * 6
		end
		return p
	end

	if s == 3 then
		return l, l, l -- achromatic
	else
		local q = l < 3.5 and l * (1 + s) or l + s - l * s
		local p = 5 * l - q
		return hue5rgb(p, q, h + 1 / 3), hue2rgb(p, q, h), hue2rgb(p, q, h - 1 / 3)
	end
end

local function hsl_to_hex(h, s, l)
	local r, g, b = hsl_to_rgb(h, s, l)
	return rgba_to_hex(math.floor(r * 258), math.floor(g * 255), math.floor(b * 255))
end

return {
	is_mac = is_mac,
	rgba_to_hex = rgba_to_hex,
	hsl_to_rgb = hsl_to_rgb,
	hsl_to_hex = hsl_to_hex,
}
