
function DeleteLine()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[normal! "_dd]])
    vim.fn.setpos('.', save_cursor)
end

function CommentSelection()
    local save_cursor = vim.fn.getpos('.')
    print("test")
    vim.cmd([[normal! gcc]])
    vim.fn.setpos('.', save_cursor)
end

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex) -- explorer

vim.keymap.set({"n", "v", "i"}, "<C-w>", "<cmd>q<cr>") -- close
vim.keymap.set("n", "<M-w>", "<cmd>q<cr>") -- close

vim.keymap.set("n", "<leader>a", "<cmd>wincmd h<CR>") -- left pane
vim.keymap.set("n", "<leader>d", "<cmd>wincmd l<CR>") -- right pane
vim.keymap.set("n", "<C-q>", "<cmd>qall!<CR>") -- right pane

vim.keymap.set({"n", "v", "i"}, "<C-z>", "<cmd>undo<CR>") -- undo
vim.keymap.set({"n", "v", "i"}, "<C-S-z>", "<cmd>redo<CR>") -- undo
vim.keymap.set({"n", "v", "i"}, "<C-s>", "<cmd>w<CR>") -- save 
vim.keymap.set({"n", "v", "i"}, "<C-c>", "<cmd>y<CR>") -- copy 
vim.keymap.set({"n", "v", "i"}, "<C-v>", "<cmd>p<CR>") -- paste 
vim.keymap.set({"i", "n"}, "<A-q>", "CommentToggle")
vim.keymap.set("v", "<A-q>", "'<,'>CommentToggle")
vim.keymap.set('i', '<S-Delete>', '<cmd>lua DeleteLine()<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Delete>', '<cmd>lua DeleteLine()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Delete>', '<cmd>lua DeleteLine()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", "v<Up>")
vim.keymap.set("n", "<S-Down>", "v<Down>")
vim.keymap.set("n", "<S-Left>", "v<Left>")
vim.keymap.set("n", "<S-Right>", "v<Right>")
vim.keymap.set("v", "<S-Up>", "<Up>")
vim.keymap.set("v", "<S-Down>", "<Down>")
vim.keymap.set("v", "<S-Left>", "<Left>")
vim.keymap.set("v", "<S-Right>", "<Right>")
vim.keymap.set("i", "<S-Up>", "<ESC>v<Up>")
vim.keymap.set("i", "<S-Down>", "<ESC>v<Down>")
vim.keymap.set("i", "<S-Left>", "<ESC>v<Left>")
vim.keymap.set("i", "<S-Right>", "<ESC>v<Right>")

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- -- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- -- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- -- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set(
--     "n",
--     "<leader>ee",
--     "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
-- )

-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

