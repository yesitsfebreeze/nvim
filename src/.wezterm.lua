local wezterm = require 'wezterm'


local mux = wezterm.mux

local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox'

config.font = wezterm.font 'DepartureMono Nerd Font'
config.font_size = 16.5
config.window_decorations = 'RESIZE'

config.animation_fps = 60
config.adjust_window_size_when_changing_font_size = false
config.debug_key_events = false
config.native_macos_fullscreen_mode = false
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0.5
config.win32_system_backdrop = 'Mica'
config.macos_window_background_blur = 25

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false


config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

config.colors = {
	background = '${DARK0_SOFT}',
	cursor_bg = '${CURSOR_BG}',
	cursor_fg = '${CURSOR_FG}',
}

config.background = {
	{
		source = {
			File = { path = '${USR_DIR}/.config/wezterm/bg.gif' }
		},
		height = 'Cover',
		width = 'Cover',
		horizontal_align = 'Center',
		vertical_align = 'Middle',
		repeat_x = 'NoRepeat',
		repeat_y = 'NoRepeat',
		opacity = 0.4,
	},
	{
		source = {
			Color = '${DARK0_SOFT}'
		},
		width = '100%',
		height = '100%',
		opacity = 0.61
	},
}


-- tmux
config.leader = { key = 'Equal', mods = 'ALT', timeout_milliseconds = 1000 }

local act = wezterm.action
config.keys = {
	{
		key = 's',
		mods = 'LEADER',
		action = act.ActivateKeyTable {
			name = 'split_pane',
			one_shot = true,
		},
	},
	{
		mods = 'CMD|CTRL',
		key = 'w',
		action = wezterm.action.CloseCurrentPane { confirm = true }
	},
}


config.key_tables = {
	split_pane = {
		{ key = 'LeftArrow',  action = act.SplitPane { direction = 'Left', size = { Percent = 50 } } },
		{ key = 'RightArrow', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },
		{ key = 'DownArrow',  action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },
		{ key = 'UpArrow',    action = act.SplitPane { direction = 'Up', size = { Percent = 50 } } },
	}
}

wezterm.on('update-right-status', function(window, _)
	local status = ''
	if window:leader_is_active() then status = ' waiting' end
	if window:active_key_table() then status = ' ' .. window:active_key_table() end

	window:set_right_status(wezterm.format {
		{ Background = { Color = '${BRIGHT_ORANGE}' } },
		{ Foreground = { Color = '${DARK0_HARD}' } },
		{ Text = status },
	})

	-- local name = window:active_key_table()
	-- window:set_right_status(wezterm.format {
	-- 	{ Background = { Color = '${BRIGHT_ORANGE}' } },
	-- 	{ Text = name or '' },
	-- })
end)

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)


return config
