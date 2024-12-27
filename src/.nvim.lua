-- be able to load lua files from the same directory
local xdg_dir = os.getenv("HOME") .. '/.config/nvim'
package.path = xdg_dir .. '/?.lua;' .. package.path


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

-- #region setup

vim.g.mapleader = '\\'
local autocmd = vim.api.nvim_create_autocmd

vim.opt.guicursor = 'n-v-c:block,i:block,r-cr:hor20'

vim.o.autowriteall = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 99999
-- vim.opt.signcolumn = 'yes'
-- vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.cmd('highlight OverLength ctermbg=red ctermfg=white guibg=#592929')
vim.cmd('match OverLength /\\%71v.\\+/')


-- #endregion setup

-- #region lazy
-- lazy.vim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out,                            'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	spec = {
		{
			'ellisonleao/gruvbox.nvim',
			name = 'gruvbox',
			priority = 1000,
			config = function()
				require('gruvbox').setup({
					terminal_colors = true, -- add neovim terminal colors
					undercurl = true,
					underline = true,
					bold = true,
					italic = {
						strings = true,
						emphasis = true,
						comments = true,
						operators = false,
						folds = true,
					},
					strikethrough = true,
					invert_selection = false,
					invert_signs = false,
					invert_tabline = false,
					invert_intend_guides = false,
					inverse = true, -- invert background for search, diffs, statuslines and errors
					contrast = 'soft', -- can be 'hard', 'soft' or empty string
					palette_overrides = {
						dark0_hard = env.DARK0_HARD,
						dark0 = env.DARK0,
						dark0_soft = env.DARK0_SOFT,
						dark1 = env.DARK1,
						dark2 = env.DARK2,
						dark3 = env.DARK3,
						dark4 = env.DARK4,
						light0_hard = env.LIGHT0_HARD,
						light0 = env.LIGHT0,
						light0_soft = env.LIGHT0_SOFT,
						light1 = env.LIGHT1,
						light2 = env.LIGHT2,
						light3 = env.LIGHT3,
						light4 = env.LIGHT4,
						bright_red = env.BRIGHT_RED,
						bright_green = env.BRIGHT_GREEN,
						bright_yellow = env.BRIGHT_YELLOW,
						bright_blue = env.BRIGHT_BLUE,
						bright_purple = env.BRIGHT_PURPLE,
						bright_aqua = env.BRIGHT_AQUA,
						bright_orange = env.BRIGHT_ORANGE,
						neutral_red = env.NEUTRAL_RED,
						neutral_green = env.NEUTRAL_GREEN,
						neutral_yellow = env.NEUTRAL_YELLOW,
						neutral_blue = env.NEUTRAL_BLUE,
						neutral_purple = env.NEUTRAL_PURPLE,
						neutral_aqua = env.NEUTRAL_AQUA,
						neutral_orange = env.NEUTRAL_ORANGE,
						faded_red = env.FADED_RED,
						faded_green = env.FADED_GREEN,
						faded_yellow = env.FADED_YELLOW,
						faded_blue = env.FADED_BLUE,
						faded_purple = env.FADED_PURPLE,
						faded_aqua = env.FADED_AQUA,
						faded_orange = env.FADED_ORANGE,
						dark_red_hard = env.DARK_RED_HARD,
						dark_red = env.DARK_RED,
						dark_red_soft = env.DARK_RED_SOFT,
						light_red_hard = env.LIGHT_RED_HARD,
						light_red = env.LIGHT_RED,
						light_red_soft = env.LIGHT_RED_SOFT,
						dark_green_hard = env.DARK_GREEN_HARD,
						dark_green = env.DARK_GREEN,
						dark_green_soft = env.DARK_GREEN_SOFT,
						light_green_hard = env.LIGHT_GREEN_HARD,
						light_green = env.LIGHT_GREEN,
						light_green_soft = env.LIGHT_GREEN_SOFT,
						dark_aqua_hard = env.DARK_AQUA_HARD,
						dark_aqua = env.DARK_AQUA,
						dark_aqua_soft = env.DARK_AQUA_SOFT,
						light_aqua_hard = env.LIGHT_AQUA_HARD,
						light_aqua = env.LIGHT_AQUA,
						light_aqua_soft = env.LIGHT_AQUA_SOFT,
						gray = env.GRAY,
					},
					overrides = {
						CursorLine = {
							bg = nil,
						},
						Cursor = {
							fg = env.CURSOR_FG,
							bg = env.CURSOR_BG,
						},
					},
					dim_inactive = false,
					transparent_mode = true,
				})
			end
		},
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				local _theme = {
					normal = {
						a = { fg = env.BRIGHT_GREEN, bg = env.DARK0_HARD },
						b = { fg = env.LIGHT0_SOFT, bg = nil },
						c = { fg = env.LIGHT0_SOFT, bg = nil },
					},

					insert = { a = { fg = env.BRIGHT_YELLOW, bg = env.DARK0_HARD } },
					visual = { a = { fg = env.BRIGHT_AQUA, bg = env.DARK0_HARD } },
					replace = { a = { fg = env.BRIGHT_RED, bg = env.DARK0_HARD } },

					inactive = {
						a = { fg = env.LIGHT0_SOFT, bg = env.DARK0_HARD },
						b = { fg = env.LIGHT0_SOFT, bg = env.DARK0_HARD },
						c = { fg = env.LIGHT0_SOFT, bg = nil },
					},
				}

				require('lualine').setup {
					options = {
						theme = _theme,
						section_separators = { left = '', right = '' },
					},
					sections = {
						lualine_a = { { 'mode' } },
						lualine_b = { 'filename', 'branch' },
						lualine_c = {
							'%=', --[[ add your center compoentnts here in place of this comment ]]
						},
						lualine_x = {},
						lualine_y = { 'filetype', 'progress' },
						lualine_z = { { 'location' }, },
					},
					inactive_sections = {
						lualine_a = { 'filename' },
						lualine_b = {},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = { 'location' },
					},
					tabline = {},
					extensions = {},
				}
			end
		},
		{
			'terrortylor/nvim-comment',
			config = function()
				require('nvim_comment').setup({
					operator_mapping = "<A-q>"
				})
			end
		},
		{
			'rmagatti/auto-session',
			lazy = false,
			opts = {
				allowed_dirs = { env.DEV_FOLDER .. '/*' }
			}
		},
		{
			'ThePrimeagen/harpoon',
			branch = 'harpoon2',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{
			'sphamba/smear-cursor.nvim',
			opts = {
				cursor_color = env.CURSOR_BG,
				legacy_computing_symbols_support = true,
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = {
						"c",
						"lua",
						"vim",
						"vimdoc",
						"query",
						"elixir",
						"heex",
						"javascript",
						"html"
					},
					sync_install = false,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end
		},
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		}
	},
	change_detection = { notify = false },
	checker = { enabled = true },
})
-- #endregion lazy

-- #region conf
local harpoon = require('harpoon')
harpoon:setup({})
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require('telescope.pickers').new({}, {
		prompt_title = 'Harpoon',
		finder = require('telescope.finders').new_table({
			results = file_paths,
		}),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end
-- #endregion conf

-- #region remaps
local opts = { noremap = true, silent = true }

local harpoon = require('harpoon')


local function modebind(bind, act)
	vim.keymap.set('n', bind, act)
	vim.keymap.set('v', bind, act)
	vim.keymap.set('i', bind, act)
end

vim.keymap.set('n', '<leader>w', function() harpoon:list():add() end)
vim.keymap.set('n', '<leader>a', function() harpoon:list():prev() end)
vim.keymap.set('n', '<leader>d', function() harpoon:list():next() end)

vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)

vim.keymap.set('n', '<leader>s', function() toggle_telescope(harpoon:list()) end)
vim.keymap.set('n', '<leader>o', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>f', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)           -- save
vim.keymap.set('n', '<leader>q', ':q<CR>', opts)       -- quit
vim.keymap.set('n', '<leader>Q', ':q!<CR>', opts)      -- force quit
vim.keymap.set('n', '<leader>ss', ':vsplit<CR>', opts) -- split

-- i want this to create a pane if it doesnt exists
-- then switch between the panes
vim.keymap.set('n', '<leader>l', '<C-w>w', opts)           -- switch between panes

vim.keymap.set({ "n", "v", "i" }, '<D-s>', ':w<CR>', opts) -- save

-- #endregion remaps


vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
