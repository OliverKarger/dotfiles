" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
   
	" COC	
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

	" Theme
    Plug 'morhetz/gruvbox'

	" LSP
	Plug 'williamboman/mason.nvim'

	" Airline Status Bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
	
	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-file-browser.nvim'

	" fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Terminal Plugin
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
	
	" Snippets
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'

call plug#end()
