local wz = require('wezterm')

-- be able to load lua files from the same directory
local xdg_dir = wz.home_dir .. '/.config/wezterm'
package.path = xdg_dir .. '/?.lua;' .. package.path

local sessions = require('sessions')
local wzm = wz.mux


-- #region env
local function load_env_file(file_path)
	local env_vars = {}
	local file = io.open(file_path, "r")

	if not file then
		error("Could not open .env file: " .. file_path)
	end

	for line in file:lines() do
		if line:match("^#") or line:match("^%s*$") then goto continue end

		local key, value = line:match("^%s*([^=]+)%s*=%s*(.+)%s*$")
		if key and value then
			value = value:gsub('^"(.*)"$', "%1")
			value = value:gsub("^'(.*)'$", "%1")
			value = value:gsub("^%s*(.-)%s*$", "%1")
			env_vars[key] = value
		end

		::continue::
	end

	file:close()
	return env_vars
end

local env = load_env_file(xdg_dir .. '/.env')
-- #endregion env

-- https://wezfurlong.org/wezterm/config/lua/wezterm.mux/set_active_workspace.html
-- https://wezfurlong.org/wezterm/config/lua/wezterm.mux/get_active_workspace.html
-- want to load from a file
local function save_session()
	local window = wzm.get_window(0):gui_window()
	sessions.save_state(window)
end

local function restore_session()
	local window = wzm.get_window(0):gui_window()
	sessions.restore_state(window)
end

wz.time.call_after(10, save_session)

local config = wz.config_builder()

config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wz.font 'DepartureMono Nerd Font'
config.line_height = 1.0
config.font_size = 15
config.scrollback_lines = 3500
config.window_decorations = 'RESIZE'
config.animation_fps = 60
config.adjust_window_size_when_changing_font_size = false
config.debug_key_events = false
config.native_macos_fullscreen_mode = false
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0.7
config.win32_system_backdrop = 'Mica'
config.macos_window_background_blur = 10
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.default_cursor_style = 'SteadyBlock'
config.enable_tab_bar = false

config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

config.colors = {
	background = env.DARK0_SOFT,
	cursor_bg = env.CURSOR_BG,
	cursor_fg = env.CURSOR_FG,
}

config.background = {
	{
		source = {
			Color = '#000000'
		},
		width = '100%',
		height = '100%',
		opacity = 0.6
	},
	{
		source = {
			File = { path = xdg_dir .. '/bg.png' }
		},
		height = '100%',
		width = '100%',
		horizontal_align = 'Right',
		vertical_align = 'Middle',
		repeat_x = 'NoRepeat',
		repeat_y = 'NoRepeat',
		opacity = 0.5,
	},
	{
		source = {
			Color = env.DARK0_SOFT
		},
		width = '100%',
		height = '100%',
		opacity = 0.71
	}
}

local act = wz.action
config.keys = {

	{ key = 'w',      mods = 'CMD',       action = act.ActivatePaneDirection('Up') },
	{ key = 'a',      mods = 'CMD',       action = act.ActivatePaneDirection('Left') },
	{ key = 's',      mods = 'CMD',       action = act.ActivatePaneDirection('Down') },
	{ key = 'd',      mods = 'CMD',       action = act.ActivatePaneDirection('Right') },

	{ key = 'w',      mods = 'CMD|SHIFT', action = act.SplitPane { direction = 'Up', size = { Percent = 50 } } },
	{ key = 'a',      mods = 'CMD|SHIFT', action = act.SplitPane { direction = 'Left', size = { Percent = 50 } } },
	{ key = 's',      mods = 'CMD|SHIFT', action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },
	{ key = 'd',      mods = 'CMD|SHIFT', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },

	{ key = 'Escape', mods = 'CMD',       action = wz.action.CloseCurrentPane { confirm = true } },
}


wz.on('gui-startup', function(cmd)
	local tab, pane, window = wzm.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
	restore_session()
end)

return config
