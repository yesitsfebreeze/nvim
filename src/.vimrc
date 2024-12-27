let g:netrw_banner = 0 
set ssop-=options    " do not store global and local values in a session "
set ssop-=folds      " do not store folds "

" autosave "
if has("gui_running")
	autocmd FocusLost * :wa
endif

" shift+arrow selection "
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
inoremap <S-Up> <Esc>v<Up>
inoremap <S-Down> <Esc>v<Down>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc>v<Right>

" delete line "
nnoremap <S-Del> dd
vnoremap <S-Del> d
inoremap <S-Del> <Esc>ddi

nnoremap <D-z> :undo<CR>
vnoremap <D-z> :undo<CR>
inoremap <D-z> :undo<CR>

if has('nvim')
	luafile ~/.config/nvim/.nvim.lua
endif