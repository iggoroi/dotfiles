local wezterm = require("wezterm")
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

wezterm.on("choice-project", function(window, pane)
	local choices = {}
	for _, filename in ipairs(wezterm.read_dir([[C:\Users\Giorgio\Documents\Projects\]])) do
		table.insert(choices, { label = string.gsub(filename, [[C:\Users\Giorgio\Documents\Projects\]], "") })
	end
	window:perform_action(
		wezterm.action.InputSelector({
			choices = choices,
			fuzzy = true,
			action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
				if label then
					local cwd = [[C:\Users\Giorgio\Documents\Projects\]] .. label
					inner_window:perform_action(
						wezterm.action.SpawnCommandInNewTab({
							label = label,
							args = { "nvim", "." },
							cwd = cwd,
						}),
						inner_pane
					)
					window:active_tab():set_title(label)
				end
			end),
		}),
		pane
	)
end)

local keys = {
	{
		key = "Tab",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.InputSelector({
			choices = {
				{ label = "config", id = "C:/Users/Giorgio/AppData/Local/nvim" },
				{ label = "projects", id = "C:/Users/Giorgio/Documents/Projects" },
			},
			title = "Neovim start",
			action = wezterm.action_callback(function(window, pane, id, label)
				if id and label then
					if label == "projects" then
						window:perform_action(wezterm.action.EmitEvent("choice-project"), pane)
					else
						window:perform_action(
							wezterm.action.SpawnCommandInNewTab({ args = { "nvim", "." }, cwd = id }),
							pane
						)
					end
				end
				wezterm.sleep_ms(1000)
			end),
		}),
	},
}

return {
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	enable_tab_bar = false,
	color_scheme = "Marrakesh (dark) (terminal.sexy)",
	term = "wezterm",
	default_prog = { "pwsh" },
	window_decorations = "NONE|RESIZE",
	cursor_blink_rate = 500,
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Linear",
	cursor_blink_ease_out = "Linear",
	animation_fps = 1,
	keys = keys,
	font = wezterm.font("JetBrainsMono Nerd Font Propo", { weight = "Regular", stretch = "Normal", style = "Normal" }), -- (AKA: JetBrainsMono NFM) C:\USERS\GIORGIO\APPDATA\LOCAL\MICROSOFT\WINDOWS\FONTS\JETBRAINSMONONERDFONTMONO-REGULAR_1.TTF, DirectWrite
	font_size = 14.0,
	automatically_reload_config = true,
}
