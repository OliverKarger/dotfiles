" Load Plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" --- Settings: Start --- 
set termguicolors
set number
set shiftwidth=4
set tabstop=4
filetype indent on
let g:loaded_netrwPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
" --- Settins: End ---

" --- Toggelterm: Start ---
lua require("toggleterm").setup{}
" --- Toggleterm: End ---

" --- LSP: Start ---
lua <<EOF
require"nvim-lsp-installer".setup{
	automatic_installation = true
}
EOF
lua require('lspconfig').csharp_ls.setup{}
lua require('lspconfig').vimls.setup{}
" --- LSP: End ---

" --- Telescope: Start ---
autocmd VimEnter * silent! lua require('telescope.builtin').find_files()
lua << EOF
require'telescope'.setup {
	defaults = {
		find_command = {
		    'rg',
      		'--color=never',
      		'--no-heading',
      		'--with-filename',
      		'--line-number',
      		'--column',
      		'--smart-case',
      		'--binary-files=without-match',  -- Ignore binary files
			'--type=f'
		}
	}	
}
EOF
nnoremap <C-e> :Telescope file_browser<CR>
nnoremap <C-s> :Telescope find_files<CR>
" --- Telescope: End ---

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

" --- Window Navigation: Start ---
nnoremap <silent> <C-w><Up> <C-w>k
nnoremap <silent> <C-w><Down> <C-w>j
nnoremap <silent> <C-w><Left> <C-w>h
nnoremap <silent> <C-w><Right> <C-w>l
" --- Window Navigation: End ---
