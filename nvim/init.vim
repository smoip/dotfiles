" probably lives at ~/.config/nvim/
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
set clipboard=unnamed                 " use system clipboard

"""" Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" treesitter
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" tpope
Plugin 'tpope/vim-rails' " this does additional highlighting not covered by treesitter
Plugin 'tpope/vim-fugitive'

" interface
Plugin 'tpope/vim-commentary'         " alternate commenting

Plugin 'tpope/vim-surround'           " parenthesis, brackets, tags, etc.
Plugin 'simnalamburt/vim-mundo'       " visual undo tree
Plugin 'haya14busa/incsearch.vim'
Plugin 'folke/tokyonight.nvim'
Plugin 'jacoborus/tender.vim'

Plugin 'nvim-lua/plenary.nvim'        " telescope dependency
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}  " Faster sorting

" LSP/Mason
Plugin 'williamboman/mason.nvim'
Plugin 'williamboman/mason-lspconfig.nvim'
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/nvim-cmp'           " Completion engine
Plugin 'hrsh7th/cmp-nvim-lsp'       " LSP completion source
Plugin 'hrsh7th/cmp-buffer'         " Buffer completion
Plugin 'hrsh7th/cmp-path'           " Path completion
Plugin 'L3MON4D3/LuaSnip'           " Snippet engine
Plugin 'saadparwaiz1/cmp_luasnip'   " Snippet completion

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


" treesitter config script
" on a fresh install, you may need to run :TSInstall before this will function
lua require('treesitter-config')

" telescope config script
lua require('treesitter-config')

" LSP config script
lua require('lsp-config')

"""" Mappings
" telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

""" Shit I have changed recently and will not remember

" full path of markdown file - needs to be placed manually
" on a fresh install
let g:cheat_sheet_path = '~/.config/nvim/cheatsheet.md'

command! Cheat call s:OpenCheatSheet()

function! s:OpenCheatSheet()
  let cheat_file = expand(g:cheat_sheet_path)
  let buf = nvim_create_buf(v:false, v:true)
  let lines = readfile(cheat_file)
  call nvim_buf_set_lines(buf, 0, -1, v:true, lines)
  let width = 70
  let height = min([len(lines) + 2, &lines - 10])
  let opts = {
        \ 'relative': 'editor',
        \ 'width': width,
        \ 'height': height,
        \ 'col': (&columns - width) / 2,
        \ 'row': (&lines - height) / 2,
        \ 'style': 'minimal',
        \ 'border': 'rounded'
        \ }
  let win = nvim_open_win(buf, v:true, opts)
  call nvim_buf_set_option(buf, 'modifiable', v:false)
  call nvim_buf_set_option(buf, 'filetype', 'markdown')
  nnoremap <buffer><silent> q :close<CR>
  nnoremap <buffer><silent> <Esc> :close<CR>
  execute 'nnoremap <buffer><silent> e :close<CR>:e ' . g:cheat_sheet_path . '<CR>'
endfunction

nnoremap <leader>? :Cheat<CR>
