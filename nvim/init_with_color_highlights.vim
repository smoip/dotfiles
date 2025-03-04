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

" color helper
Plugin 'ap/vim-css-color'

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

augroup CSS_HSL
    autocmd!
    " autocmd FileType css syntax match cssHSLValue /\v\d+\.?\d*\s+\d+\.?\d*\%\s+\d+\.?\d*\%/ contained containedin=cssDefinition
    autocmd FileType css syntax match cssHSLValue /\v^\s*--[a-zA-Z0-9-]+:\s*\d+\.?\d*\s+\d+\.?\d*\%\s+\d+\.?\d*\%\s*;/ contained containedin=cssDefinition
    " autocmd FileType css highlight link cssHSLValue cssProp
    autocmd FileType css highlight cssHSLValue ctermbg=135 guibg=#af5fff
augroup END

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

highlight ExtraWhitespace ctermbg=cyan guibg=#346b61
match ExtraWhitespace /\s\+$/

"""" Plugin settings
let NERDSpaceDelims = 1               " space after comment char

"""" Macros
" source $VIMRUNTIME/macros/matchit.vim      " not on by default for some reason

" HSL to RGB conversion function
function! s:hsl_to_rgb(h, s, l)
    let l:h = a:h / 360.0
    let l:s = a:s / 100.0
    let l:l = a:l / 100.0

    if l:s == 0
        let l:r = l:l
        let l:g = l:l
        let l:b = l:l
    else
        let l:q = l:l < 0.5 ? l:l * (1 + l:s) : l:l + l:s - l:l * l:s
        let l:p = 2 * l:l - l:q

        let l:r = s:hue_to_rgb(l:p, l:q, l:h + 1/3.0)
        let l:g = s:hue_to_rgb(l:p, l:q, l:h)
        let l:b = s:hue_to_rgb(l:p, l:q, l:h - 1/3.0)
    endif

    return [float2nr(l:r * 255), float2nr(l:g * 255), float2nr(l:b * 255)]
endfunction

function! s:hue_to_rgb(p, q, t)
    let l:t = a:t
    if l:t < 0
        let l:t += 1
    endif
    if l:t > 1
        let l:t -= 1
    endif
    if l:t < 1/6.0
        return a:p + (a:q - a:p) * 6 * l:t
    elseif l:t < 1/2.0
        return a:q
    elseif l:t < 2/3.0
        return a:p + (a:q - a:p) * (2/3.0 - l:t) * 6
    endif
    return a:p
endfunction

" Function to set highlighting for matched HSL values
function! s:SetHSLHighlight()
    let l:line = getline('.')
    " Updated pattern to handle more HSL variations
    let l:matches = matchlist(l:line, '\v^\s*--[a-zA-Z0-9-]+:\s*(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\%\s+(-?\d+\.?\d*)\%\s*;')
    if !empty(l:matches)
        let [l:h, l:s, l:l] = [str2float(l:matches[1]), str2float(l:matches[2]), str2float(l:matches[3])]
        let [l:r, l:g, l:b] = s:hsl_to_rgb(l:h, l:s, l:l)
        let l:rgb = printf('#%02x%02x%02x', l:r, l:g, l:b)
        execute 'highlight HSLColor' . line('.') . ' guibg=' . l:rgb
        execute 'syntax match HSLColor' . line('.') . ' /\%' . line('.') . 'l\v^\s*--[a-zA-Z0-9-]+:\s*-?\d+\.?\d*\s+-?\d+\.?\d*\%\s+-?\d+\.?\d*\%\s*;/ containedin=ALL'
    endif
endfunction

let g:hsl_highlighting_enabled = 1  " Enable by default

" Toggle function
function! ToggleHSLHighlight()
    if g:hsl_highlighting_enabled
        let g:hsl_highlighting_enabled = 0
        " Clear all HSL highlights
        silent! syntax clear HSLColor\d\+
        " Clear all highlight groups
        for l:lnum in range(1, line('$'))
            execute 'highlight clear HSLColor' . l:lnum
        endfor
        " Force syntax reload
        syntax sync fromstart
        redraw!
        echo "HSL highlighting disabled"
    else
        let g:hsl_highlighting_enabled = 1
        " Reapply highlights
        call s:SetHighlightsForBuffer()
        echo "HSL highlighting enabled"
    endif
endfunction

" Function to set highlights for entire buffer
function! s:SetHighlightsForBuffer()
    if !g:hsl_highlighting_enabled
        return
    endif
    let l:save_cursor = getcurpos()
    silent! syntax clear HSLColor\d\+
    for l:lnum in range(1, line('$'))
        call cursor(l:lnum, 1)
        call s:SetHSLHighlight()
    endfor
    call setpos('.', l:save_cursor)
endfunction

augroup CSS_HSL
    autocmd!
    " Updated pattern in the autocmd as well
    autocmd FileType css syntax match cssHSLColor /\v^\s*--[a-zA-Z0-9-]+:\s*-?\d+\.?\d*\s+-?\d+\.?\d*\%\s+-?\d+\.?\d*\%\s*;/ contains=@cssColor contained containedin=cssDefinition
    autocmd BufRead,BufWritePost *.css call s:SetHighlightsForBuffer()
    autocmd TextChanged,TextChangedI *.css call s:SetHighlightsForBuffer()
augroup END

command! ToggleHSL call ToggleHSLHighlight()
