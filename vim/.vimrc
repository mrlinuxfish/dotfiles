" Runtime options {{{1

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" turn off vi compatibility so vim works better
set nocompatible

" Plugins {{{1

" Set runtime path, include Vundle plugin and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

" Plugin 'ervandew/supertab'

Plugin 'tpope/vim-fugitive'

"End Vundle
call vundle#end()

" Enable filetype detection (technically a plugin)
filetype on
filetype indent on " allows for file type indentation

" enable netrw file manager plugin
filetype plugin on

" Powerline {{{1

" Set powerline font
let g:airline_powerline_fonts = 1

" Always show statusline
set laststatus=2

" remove pause when leaving insert mode this resolves issues with airline
set ttimeoutlen=10

" set folding method
set foldmethod=marker

" Line settings and colors {{{1

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" turn off wrapping
set nowrap
set tw=0

" display relative line numbers and have current line display absolute number
set relativenumber
set number

" turn on syntax highlighting
syntax on

" turn on wildmenu (puts all possible outputs for tab completion above current line)
set wildmenu

" Search settings {{{1

" Search into subfolders
set path+=**

" Highlight searches
set hlsearch

" set pastebuffer to the + register
set clipboard=unnamedplus

" Tabs / completion {{{1

" Set tab widths
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Set makefiles to use full tabs
autocmd Filetype make set noexpandtab shiftwidth=8 softtabstop=0

" Set c-like programming tabs
autocmd FileType c,cpp,java set formatoptions+=ro

" Set autocomplete for c
autocmd FileType c set omnifunc=ccomplete#Complete

" ensure normal tabs in assembly files and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

" Set tab width for ruby
autocmd Filetype ruby set expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent

" Set autocomplete for ruby
autocmd Filetype ruby set omnifunc=syntaxcomplete#Complete

" Set markdown rules
autocmd Filetype markdown set wrap

" Remapings {{{1

" Map <leader> to ","
let mapleader = ","

" Set  <leader>p to toggle paste mode
nmap <silent> <leader>p :setlocal paste! paste?<cr>

" Set <leader>s to toggle spell
map <silent> <leader>s :setlocal spell! spelllang=en_us<cr>
inoremap ss <Esc> ]s
inoremap SS <Esc> [s

" Set rempappings for insert mode commands:

" Go to first non-blank text
inoremap ii <Esc>I

" Go to end of the line
inoremap aa <Esc>A

" Start editing new line above current
inoremap oo <Esc>O

" undo
inoremap uu <esc>u
