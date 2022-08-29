" File: .vimrc
" Author: Bryan Hundven
" Description: My .vimrc
" Last Modified: August 26, 2022

" Basic Vim Settings {{{1
set nocompatible
let &termencoding = &encoding
set encoding=utf-8

" Set mapleader {{{2
let mapleader = ","

" Show matching brackets {{{2
set showmatch

" Use wildmenu as a pop up menu {{{2
set wildmenu
set wildoptions=pum

" Enable modeline {{{2
set modeline
set modelines=5

" Centralize backups, swapfiles and undo history {{{2
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Better backspace {{{2
set backspace=indent,eol,start

" Set invisible characters {{{2
set listchars=eol:\\U00002347,tab:\\U000025B6\\U00000020,space:\\U000000B7
      \,trail:\\U000000B7

" Don't wrap lines
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>

" Folding {{{2
setlocal foldmethod=marker

" Enable filetype plugin and indent {{{2
filetype on
filetype plugin on
filetype indent on

" Color syntax {{{2
syntax on
colorscheme gotham256

" Make the default shell bash {{{2
set shell=/bin/bash

" Automatically save before commands like :next and :make {{{2
set autowrite

" Jump to the last position when reopening a file {{{2
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" | endif
endif

" Show cursor line and cursor column on the current buffer {{{2
set cursorline cursorcolumn
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn

" Set ColorColumn for the current buffer {{{2
execute "set colorcolumn=" . join(range(81,1000), ',')
au WinLeave * set colorcolumn=
au WinEnter * execute "set colorcolumn=" . join(range(81,1000), ',')
highlight ColorColumn ctermbg=darkgrey ctermfg=red

" Edit and Reload vim config file {{{2
"
" Edit vimrc configuration file {{{3
nnoremap <Leader>ve :e $MYVIMRC<CR>

" Reload vimrc configuration file {{{3
nnoremap <Leader>vr :source $MYVIMRC<CR>

" load some shipped plugins {{{1
runtime macros/matchit.vim

" Spell Checking {{{1
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Use deoplete completion {{{1
let g:ale_completion_enabled = 1

" Enable deoplete on startup {{{1
let g:deoplete#enable_at_startup = 1

" Don't automatically align... yet... {{{1
let g:puppet_align_hashes = 0

" GitGutter Settings {{{1
let g:gitgutter_git_executable = '/usr/bin/git'

" Airline settings {{{1
" Airline options {{{2
let g:airline_powerline_fonts=1
let g:airline_theme='deus'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
" Airline Extensions {{{2
" enable airline tabline
let g:airline#extensions#tabline#enabled = 1
" only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#tab_min_count = 2
" do not show open buffers in tabline
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Toggle invisible characters {{{1
nnoremap <silent> <leader>l :set list!<CR>

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
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
      \ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene
      \| endif
"map <C-n> :NERDTreeToggle<CR>

" Get or Update Plugins {{{1

" Our dictionary of vim plugins {{{2
let g:plugins = {
\ 'ale': 'https://github.com/dense-analysis/ale.git',
\ 'deoplete.nvim' : 'https://github.com/Shougo/deoplete.nvim.git',
\ 'nerdtree': 'https://github.com/preservim/nerdtree.git',
\ 'nvim-yarp': 'https://github.com/roxma/nvim-yarp.git',
\ 'rust.vim': 'https://github.com/rust-lang/rust.vim',
\ 'tagbar': 'https://github.com/preservim/tagbar.git',
\ 'vim-airline': 'https://github.com/vim-airline/vim-airline.git',
\ 'vim-airline-themes': 'https://github.com/vim-airline/vim-airline-themes.git',
\ 'vim-fugitive': 'https://github.com/tpope/vim-fugitive.git',
\ 'vim-gitgutter': 'https://github.com/airblade/vim-gitgutter.git',
\ 'vim-hug-neovim-rpc': 'https://github.com/roxma/vim-hug-neovim-rpc.git',
\ 'vim-puppet': 'https://github.com/rodjek/vim-puppet.git',
\}

nnoremap <silent> <leader>u :call GetOrUpdatePlugins()<CR>

" Load All Vim Plugins {{{1
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall!

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
" }}}
"
" vim: ts=2:sw=2:sts=2:et:ai
