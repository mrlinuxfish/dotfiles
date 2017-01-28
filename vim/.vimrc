" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" Set runtime path, include Vundle plugin and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'ervandew/supertab'

Plugin 'tpope/vim-fugitive'

"End Vundle
call vundle#end()

" Set powerline font
let g:airline_powerline_fonts = 1

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" turn off wrapping
set nowrap
set tw=0

" display relative line numbers and have current line display absolute number
set relativenumber
set number

" turn on syntax highlighting
syntax on

" set pastebuffer to the + register
set clipboard=unnamedplus

" turn off vi compatibility so vim works better
set nocompatible

" enable netrw file manager plugin
filetype plugin on

" Search into subfolders
set path+=**

" Enable filetype detection
filetype on
filetype plugin on
filetype indent on " allows for file type indentation

" Highlight searches
set hlsearch

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
