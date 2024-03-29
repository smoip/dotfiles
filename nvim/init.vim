" probably lives at ~/.config/nvim/
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
set clipboard=unnamed                 " use system clipboard

"""" Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" filetypes
Plugin 'elzr/vim-json'
Plugin 'exu/pgsql.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rodjek/vim-puppet'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'wting/rust.vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'fatih/vim-go'
Plugin 'slim-template/vim-slim'       " god willing I will never need this...
Plugin 'digitaltoad/vim-pug'
Plugin 'othree/xml.vim'
Plugin 'posva/vim-vue'
Plugin 'jeetsukumaran/vim-pythonsense'
Plugin 'tpope/vim-fugitive'           " that good shit

" interface
Plugin 'scrooloose/nerdcommenter'     " syntax-specific commenting
" Plugin 'tpope/vim-commentary'         " alternate commenting

Plugin 'tpope/vim-surround'           " parenthesis, brackets, tags, etc.
Plugin 'ctrlpvim/ctrlp.vim'           " fuzzy file finder
Plugin 'simnalamburt/vim-mundo'       " visual undo tree
Plugin 'haya14busa/incsearch.vim'
Plugin 'folke/tokyonight.nvim'
Plugin 'jacoborus/tender.vim'

call vundle#end()

syntax on                             " syntax highlighting
filetype plugin indent on             " per-filetype plugins
" colorscheme railscasts              " python incompatible ;(

" Tokyonight Colorscheme config
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = { 'hint': 'orange', 'error': '#ff0000' }
colorscheme tokyonight

set smartindent
set shiftround
set softtabstop=2                     " 2 space tabs (soft) 
set tabstop=2                         " 2 space tabs (hard)
set expandtab                         " use soft tabs
set shiftwidth=2                      " width of line-initial tab 
set mouse=nv                          " let the mouse do stuff
set t_Co=256                          " use 256 colors
set background=dark
set ruler
set title
set showmatch
set number
set omnifunc=syntaxcomplete#Complete

"""" Plugin settings
let NERDSpaceDelims = 1               " space after comment char

"""" Macros
" source $VIMRUNTIME/macros/matchit.vim      " not on by default for some reason
