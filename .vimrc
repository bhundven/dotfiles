" File: .vimrc
" Author: Bryan Hundven
" Description: My .vimrc
" Last Modified: Jan 24, 2025

" Basic Vim Settings {{{1
set keyprotocol=ghostty:kitty
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
" List of unicode characters:
" https://en.wikipedia.org/wiki/List_of_Unicode_characters
" eol:⍇,tab:▶<space>,space:·,trail:<space>,lead:<space>
set listchars=eol:\\U00002347,tab:\\U000025B6\\U00000020,space:\\U000000B7
      \,trail:\\U000000B7,lead:\\U000000B7

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

" OS Detection
let g:uname = system('uname -s')

" Make the default shell bash {{{2
if g:uname == "Linux"
  set shell=/bin/bash
elseif g:uname == "Darwin"
  set shell=/opt/homebrew/bin/bash
endif

" Automatically save before commands like :next and :make {{{2
set autowrite

" Jump to the last position when reopening a file {{{2
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" | endif
endif

" Set python3 to pyenv shim {{{2
let &pythonthreedll = trim(system("pyenv which python"))

" Edit and Reload vim config file {{{2
" Edit vimrc configuration file {{{3
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimrc configuration file {{{3
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Custom Command {{{2
command! -nargs=1 R :!clear && <args>

" Show cursor line and cursor column on the current buffer {{{1
set cursorline cursorcolumn

" ColorColumn toggle {{{1
nnoremap <leader>cc :call ColorColumnToggle()<cr>
function! ColorColumnToggle()
  if &colorcolumn
    set colorcolumn=
  else
    execute "set colorcolumn=" . join(range(81,1000), ',')
    highlight ColorColumn ctermbg=darkgrey ctermfg=red
  endif
endfunction

" load some shipped plugins {{{1
runtime macros/matchit.vim

" Setup some filetypes {{{1
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0 autoindent

" Spell Checking {{{1
" Toggle spell checking on and off with `,s`
nnoremap <silent> <leader>s :set spell!<CR>

" ALE Configuration {{{1
let g:ale_c_parse_makefile = 1
let g:ale_parse_compile_commands = 1
let g:ale_completion_enabled = 1
set omnifunc=syntaxcomplete#Complete
set omnifunc=ale#completion#OmniFunc

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
au BufRead,BufNewFile */.github/workflows/*.y{,a}ml
\  let b:ale_linters = {'yaml': ['actionlint']}

" Don't automatically align... yet... {{{1
let g:puppet_align_hashes = 0

" GitGutter Settings {{{1
if g:uname == "Linux"
  let g:fugitive_git_executable = '/usr/bin/git'
  let g:gitgutter_git_executable = '/usr/bin/git'
elseif g:uname == "Darwin"
  let g:fugitive_git_executable = '/opt/homebrew/bin/git'
  let g:gitgutter_git_executable = '/opt/homebrew/bin/git'
endif
let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1
" GitGutter Toggle {{{2
nnoremap <leader>gg :GitGutterToggle<cr>

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
nnoremap <F8> :TagbarToggle<CR>

" Setup NerdTree {{{1
" Toggle NERDTree
nnoremap <silent> <leader>k :NERDTreeToggle<CR>
" " expand to the path of the file in the current buffer
nnoremap <silent> <leader>y :NERDTreeFind<CR>
"
let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = "\u25B7"
let NERDTreeDirArrowCollapsible = "\u25BC"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
      \ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene
      \| endif
"map <C-n> :NERDTreeToggle<CR>

" Setup vim-terraform {{{1
let g:hcl_align=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Get or Update Plugins {{{1
nnoremap <silent> <leader>u :call GetOrUpdatePlugins()<CR>

" Our dictionary of vim plugins {{{2
let g:plugins = {
\ 'ale': 'https://github.com/dense-analysis/ale.git',
\ 'ansible-vim': 'https://github.com/pearofducks/ansible-vim.git',
\ 'nerdtree': 'https://github.com/preservim/nerdtree.git',
\ 'nvim-yarp': 'https://github.com/roxma/nvim-yarp.git',
\ 'rust.vim': 'https://github.com/rust-lang/rust.vim',
\ 'tagbar': 'https://github.com/preservim/tagbar.git',
\ 'vim-airline': 'https://github.com/vim-airline/vim-airline.git',
\ 'vim-airline-themes': 'https://github.com/vim-airline/vim-airline-themes.git',
\ 'vim-fugitive': 'https://github.com/tpope/vim-fugitive.git',
\ 'vim-gitgutter': 'https://github.com/airblade/vim-gitgutter.git',
\ 'vim-puppet': 'https://github.com/rodjek/vim-puppet.git',
\ 'awesome-vim-colorschemes':
\ 'https://github.com/rafi/awesome-vim-colorschemes.git',
\ 'vim-gist': 'https://github.com/mattn/vim-gist.git',
\ 'webapi-vim': 'https://github.com/mattn/webapi-vim.git',
\ 'Jenkinsfile-vim-syntax':
\ 'https://github.com/martinda/Jenkinsfile-vim-syntax.git',
\ 'vim-virtualenv': 'https://github.com/jmcantrell/vim-virtualenv.git',
\ 'vim-pyenv': 'https://github.com/lambdalisue/vim-pyenv.git',
\ 'vim-surround': 'https://github.com/tpope/vim-surround.git',
\ 'vim-repeat': 'https://github.com/tpope/vim-repeat.git',
\ 'vim-hcl': 'https://github.com/jvirtanen/vim-hcl.git',
\ 'vim-trivy': 'https://github.com/aquasecurity/vim-trivy.git',
\ 'vim-terraform': 'https://github.com/hashivim/vim-terraform.git',
\ 'vim-go': 'https://github.com/fatih/vim-go.git',
\}

" Setup Gist {{{1
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL%'
let g:gist_show_privates = 1
let g:gist_get_multiplefile = 1

" Load All Vim Plugins {{{1
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall!

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
" }}}
"
hi Normal guibg=NONE ctermbg=NONE
" vim: ts=2:sw=2:sts=2:et:ai
