set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

"""" Plugins
call vundle#begin()

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

" interface
Plugin 'scrooloose/nerdcommenter'     " syntax-specific commenting
Plugin 'tpope/vim-surround'           " parenthesis, brackets, tags, etc.

call vundle#end()

syntax on                             " syntax highlighting
filetype plugin indent on             " per-filetype plugins
colorscheme railscasts                " I feel like people use this one

set smartindent
set shiftwidth=2                      " width of line-initial tab 
set shiftround
set softtabstop=2                     " 2 space tabs (soft) 
set tabstop=2                         " 2 space tabs (hard)
set expandtab                         " use soft tabs
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

"""" Mappings
" auto insert closing character
:imap ( ()<Esc>i
:imap [ []<Esc>i
:imap { {}<Esc>i

" shift-right arrow opens omnifunc completion menu
:imap <S-Right> <C-x><Tab>

" highight word under cursor w/space
:nmap <space> viw

