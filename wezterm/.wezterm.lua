local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font"),
	font_size = 14.0,
	color_scheme = "zenbones_dark",
	window_background_opacity = 0.5,
	enable_tab_bar = false,
	window_padding = {
		left = 9,
		right = 9,
		top = 9,
		bottom = 9,
	},
	enable_wayland = false,
	audible_bell = "Disabled",
	default_prog = { "/usr/bin/fish", "-l" },
	colors = {
		background = "#000000",
		--  foreground = "#f0edec",
		--  selection_bg = "#223",
		--  selection_fg = "#f0edec",
		--  cursor_bg = "#f0edec",
		--  cursor_fg = "#223",
		--  cursor_border = "#94253E",
	},
	--  window_decorations = "RESIZE",  -- This allows window decorations and resizing
}
