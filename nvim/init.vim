" Load Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" Generic Settings 
set termguicolors
set number
set shiftwidth=4
set tabstop=4
filetype indent on

" Color Scheme
colorscheme gruvbox
set background=dark
let g:airline_theme='wombat'
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" Nerdtree
autocmd VimEnter * NERDTree
nnoremap <C-b> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
