" File: .vimrc
" Author: Bryan Hundven
" Description: My .vimrc
" Last Modified: August 18, 2012

" Setup pathogen early {{{1
filetype off
call pathogen#infect()
call pathogen#helptags()

" Do auto indentation {{{1
filetype on
if has("autocmd")
  filetype plugin indent on
endif

" Drop compatibility with older vi(m) {{{1
set nocompatible
set backspace=indent,eol,start  " more powerful backspacing

" load some shipped plugins {{{1
runtime macros/matchit.vim
runtime ftplugin/main.vim

" Now we set some defaults for the editor {{{1
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time

" Other settings I like {{{1
let mapleader = ","
set cursorline      " Highlight the current line.
set title           " Show the filename in the window titlebar
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set vb t_vb=        " disable the visual bell
set wildmenu        " enables a menu at the bottom of the vim/gvim window.
set modeline        " enable modelines.
set modelines=5     " search for modelines 5 lines at the beginning and end of a file.
set shell=/bin/bash " make the default shell bash
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Syntax coloring. {{{1
syntax on
colorscheme koehler2

" Add documentation for project plugin {{{1
"helptags ~/.vim/doc ~/.vim/bundle/nerdtree/doc

" A truly useful status line {{{1
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}\ %{&fo}]\ [%l/%L,%v\ %p%%]\ [HEX=\%02.2B]
" Always show the status line
set laststatus=2

" Jump to the last position when reopening a file {{{1
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Spell Checking {{{1
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set the region to US English
set spelllang=en_us

" Save file as root (,W) {{{1
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" snipmate settings {{{1
let g:snips_author = 'Bryan Hundven'

" Toggle invisible characters (,l) {{{1
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
nmap <silent> <leader>l :set list!<CR>

" Quickly edit/reload the vimrc file {{{1
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Map Tagbar to F8 {{{1
nmap <F8> :TagbarToggle<CR>

" Setup NerdTree {{{1
" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" " expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>
"
let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>

" }}}

" Setup Airline {{{1
" airline options
let g:airline_powerline_fonts=1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
let g:airline_theme='cool'
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" vim: nowrap:foldmethod=marker:ts=2:sw=2:sts=2:et:ai
