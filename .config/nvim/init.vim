" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('~/.config/nvim/autoload')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'

" Call Plug Install to install plugins
call plug#end()

" Map leader to " "
let mapleader =" "

" Basics not taken care of by vim-sensible
set smartcase
set ignorecase
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set shiftwidth=4
set number relativenumber
set mouse=a
set nohlsearch
set nowrap
set list
set listchars=trail:·,tab:!·

" Terminal mode bindings Esc exits to normal mode, leader t opens terminal
tnoremap <Esc> <C-\><C-n>
map <leader>t :terminal<cr>

" Ctrl+Backspace erases word to the left in insert and command-line modes
noremap! <C-H> <C-W>

" Ctrl+Del erases word to the right in insert mode
inoremap <C-kDel> <space><ESC>ce

" Save file as sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Open markdown files with wrapping and spell check
autocmd FileType markdown setlocal spell! spelllang=en_us wrap linebreak

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Fix navigation controls
set splitbelow splitright
tnoremap <C-Left> <C-\><C-N><C-w>h
tnoremap <C-Down> <C-\><C-N><C-w>j
tnoremap <C-Up> <C-\><C-N><C-w>k
tnoremap <C-Right> <C-\><C-N><C-w>l
inoremap <C-Left> <C-\><C-N><C-w>h
inoremap <C-Down> <C-\><C-N><C-w>j
inoremap <C-Up> <C-\><C-N><C-w>k
inoremap <C-Right> <C-\><C-N><C-w>l
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

" Tab navigation
nnoremap <C-W><space> :tab split<cr>
nnoremap <C-S-Left> :tabp<cr>
nnoremap <C-S-Right> :tabn<cr>

"Run nvr when :editor tries to open a nested nvim instance
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd BufReadPost,BufNewFile .git/**/* set bufhidden=delete
autocmd BufReadPost,BufNewFile .git/* set bufhidden=delete
autocmd TermOpen * set bufhidden=delete

" Plugin config

" nerdtree toggle with leader n
let NERDTreeShowHidden=1
map <leader>n :NERDTreeToggle<cr>
" Use nerdtree for browsing directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if nerdtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" deoplete
let g:deoplete#enable_at_startup = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Ctrl-p
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" Load linting with ale (this must be at the end of init.vim)
packloadall
silent! helptags ALL
