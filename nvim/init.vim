" Load Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" Generic Settings 
set termguicolors
set number
set shiftwidth=4
set tabstop=4
filetype indent on

" Disable Netrw
let g:loaded_netrwPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

lua require("toggleterm").setup{}

" Automatically open Telescope if Directory is opened
augroup OpenTelescope
  autocmd!
  autocmd VimEnter * if isdirectory(expand("%:p") . "") | execute 'Telescope file_browser' | endif
augroup END

" --- Color Scheme: Start ---
colorscheme gruvbox
set background=dark
let g:airline_theme='wombat'
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
" --- Color Scheme: End ---

" --- Telescope: Start ---
nnoremap <C-e> :Telescope file_browser<CR>
nnoremap <C-s> :Telescope find_files<CR>
" --- Telescope: End ---

" --- Window Navigation: Start ---
nnoremap <silent> <C-w><Up> <C-w>k
nnoremap <silent> <C-w><Down> <C-w>j
nnoremap <silent> <C-w><Left> <C-w>h
nnoremap <silent> <C-w><Right> <C-w>l
" --- Window Navigation: End ---
