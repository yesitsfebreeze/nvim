local current_file = debug.getinfo(1, 'S').source:sub(2)   -- Get current file path
local current_dir = vim.fn.fnamemodify(current_file, ':h') -- Get the directory
package.path = current_dir .. '/?.lua;' .. package.path    -- Add the current directory to Lua's package path

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
						dark0_hard = '${DARK0_HARD}',
						dark0 = '${DARK0}',
						dark0_soft = '${DARK0_SOFT}',
						dark1 = '${DARK1}',
						dark2 = '${DARK2}',
						dark3 = '${DARK3}',
						dark4 = '${DARK4}',
						light0_hard = '${LIGHT0_HARD}',
						light0 = '${LIGHT0}',
						light0_soft = '${LIGHT0_SOFT}',
						light1 = '${LIGHT1}',
						light2 = '${LIGHT2}',
						light3 = '${LIGHT3}',
						light4 = '${LIGHT4}',
						bright_red = '${BRIGHT_RED}',
						bright_green = '${BRIGHT_GREEN}',
						bright_yellow = '${BRIGHT_YELLOW}',
						bright_blue = '${BRIGHT_BLUE}',
						bright_purple = '${BRIGHT_PURPLE}',
						bright_aqua = '${BRIGHT_AQUA}',
						bright_orange = '${BRIGHT_ORANGE}',
						neutral_red = '${NEUTRAL_RED}',
						neutral_green = '${NEUTRAL_GREEN}',
						neutral_yellow = '${NEUTRAL_YELLOW}',
						neutral_blue = '${NEUTRAL_BLUE}',
						neutral_purple = '${NEUTRAL_PURPLE}',
						neutral_aqua = '${NEUTRAL_AQUA}',
						neutral_orange = '${NEUTRAL_ORANGE}',
						faded_red = '${FADED_RED}',
						faded_green = '${FADED_GREEN}',
						faded_yellow = '${FADED_YELLOW}',
						faded_blue = '${FADED_BLUE}',
						faded_purple = '${FADED_PURPLE}',
						faded_aqua = '${FADED_AQUA}',
						faded_orange = '${FADED_ORANGE}',
						dark_red_hard = '${DARK_RED_HARD}',
						dark_red = '${DARK_RED}',
						dark_red_soft = '${DARK_RED_SOFT}',
						light_red_hard = '${LIGHT_RED_HARD}',
						light_red = '${LIGHT_RED}',
						light_red_soft = '${LIGHT_RED_SOFT}',
						dark_green_hard = '${DARK_GREEN_HARD}',
						dark_green = '${DARK_GREEN}',
						dark_green_soft = '${DARK_GREEN_SOFT}',
						light_green_hard = '${LIGHT_GREEN_HARD}',
						light_green = '${LIGHT_GREEN}',
						light_green_soft = '${LIGHT_GREEN_SOFT}',
						dark_aqua_hard = '${DARK_AQUA_HARD}',
						dark_aqua = '${DARK_AQUA}',
						dark_aqua_soft = '${DARK_AQUA_SOFT}',
						light_aqua_hard = '${LIGHT_AQUA_HARD}',
						light_aqua = '${LIGHT_AQUA}',
						light_aqua_soft = '${LIGHT_AQUA_SOFT}',
						gray = '${GRAY}',
					},
					overrides = {
						CursorLine = {
							bg = '#3c3836',
						},
						Cursor = {
							fg = "${CURSOR_FG}",
							bg = "${CURSOR_BG}",
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
				require('lualine').setup()
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
			'ThePrimeagen/harpoon',
			branch = 'harpoon2',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{
			'sphamba/smear-cursor.nvim',
			opts = {
				cursor_color = cursor_bg,
				legacy_computing_symbols_support = false,
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
		  build = ":TSUpdate",
			config = function () 
				local configs = require("nvim-treesitter.configs")
s
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

vim.keymap.set({ "n", "v", "i" }, '<C-s>', ':w<CR>', opts) -- switch between panes

-- #endregion remaps


vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox')
