" File: .vimrc
" Author: Bryan Hundven
" Description: My .vimrc
" Last Modified: Mar 14, 2026
" vi: ts=2:sw=2:et
"
" Mapping Quick Reference {{{1
"
" Leader key: ,
"
" General Toggles:
"   ,l          Toggle invisible characters
"   ,s          Toggle spell checking
"   ,o          Toggle sign column
"   ,nh         Clear search highlights
"   ,:          Open command-line history window
"
" Vimrc Management:
"   ,ve         Edit vimrc
"   ,vr         Reload vimrc
"
" fzf / Search:
"   ,f          Files
"   ,b          Buffers
"   ,g          Git files (modified/tracked)
"   ,fl         Lines (all open buffers)
"   ,fb         BLines (current buffer)
"   ,fc         Commits (git log)
"   ,fw         Windows (switch splits)
"   ,fk         Marks
"   ,ft         Filetypes
"   ,co         Colors (preview/switch colorschemes)
"   ,r          Ripgrep search
"   ,cm         Commands (searchable)
"   ,hs         History
"   ,hh         Helptags
"   ,hm         Maps (keymap browser)
"
" NERDTree:
"   ,e          Toggle NERDTree
"   ,ef         Find current file in NERDTree
"
" Git (gitgutter):
"   ,gn         Next hunk
"   ,gp         Previous hunk
"   ,gs         Stage hunk
"   ,gu         Undo hunk
"   ,gd         Preview hunk diff
"
" Comments (vim-commentary):
"   ,/          Toggle comment (normal + visual)
"   gc{motion}  Comment with motion (plugin default)
"   gcc         Comment current line (plugin default)
"
" Pyenv:
"   ,pa         Select pyenv version (fzf picker)
"   ,pd         Deactivate pyenv
"
" Plugin Management (minpac):
"   ,u          PackUpdate
"   ,c          PackClean
"   ,ps         PackStatus
"
" LSP (vim-lsp - active in buffers with a registered server):
"   gd          Go to definition
"   gD          Go to declaration
"   gi          Go to implementation
"   gt          Go to type definition
"   gr          Find references
"   gs          Search document symbols
"   gS          Search workspace symbols
"   K           Hover documentation
"   [g          Previous diagnostic
"   ]g          Next diagnostic
"   ,rn         Rename symbol
"   ,ca         Code action (quick fix)
"   ,=          Format document (visual: format selection)
"
" LSP commands (global):
"   :LspStatus              Server status
"   :LspInstallServer       Install server for current filetype
"   :LspUninstallServer     Uninstall a server (vim-lsp-settings)
"   :LspDocumentDiagnostics Show diagnostics for current buffer
"   :LspSettingsLocalEdit   Edit project-local server config
"   :LspSettingsGlobalEdit  Edit global server config
"
" Command-line Popup:
"   <Tab>       Next item / trigger completion
"   <S-Tab>     Previous item
"   <CR>        Accept selection
"   <Esc>       Close popup menu
"
" Insert-mode Completion Popup (asyncomplete):
"   <Tab>       Next item
"   <S-Tab>     Previous item
"   <CR>        Accept selection (or insert newline if no popup)
"
" ==========================================================================
" Core Settings {{{1
" ==========================================================================

" Terminal & encoding {{{2
set keyprotocol=ghostty:kitty
set encoding=utf-8

" If Vim is used inside tmux within Ghostty, you may need to force the escape
" sequences for true color:
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Leader key {{{2
let mapleader = ","

" Display {{{2
set showmatch
set number
set relativenumber
set cursorline
set signcolumn=yes
set nowrap
set sidescroll=1

" Clipboard {{{2
set clipboard=unnamedplus

" Completion (wildmenu) {{{2
set wildmenu
set wildoptions=pum
set wildmode=longest:full,full
set wildcharm=<C-z>
set wildignorecase
set pumheight=12
set shortmess+=c
set wildignore+=*.o,*.obj,*.so,*.dll,*.a,*.dylib,*.pyc,*.pyo,*.swp,*.zip,*.tar,*.gz,*.bz2,*.7z
set wildignore+=node_modules/**,target/**,dist/**,build/**,.git/**,__pycache__/**,.venv/**

" Search {{{2
set ignorecase smartcase
set incsearch hlsearch

" File handling {{{2
set autowrite
set history=10000
set updatetime=300

for d in ['~/.vim/backups', '~/.vim/swaps', '~/.vim/undo']
  if !isdirectory(expand(d))
    call mkdir(expand(d), 'p', 0700)
  endif
endfor
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set undofile

" Editing behavior {{{2
set backspace=indent,eol,start

" Invisible characters {{{2
" https://en.wikipedia.org/wiki/List_of_Unicode_characters
set listchars=eol:\\U00002347,tab:\\U000025B6\\U00000020,space:\\U000000B7
      \,trail:\\U000000B7,lead:\\U000000B7
set listchars+=precedes:<,extends:>

" Modeline {{{2
set nomodelineexpr
set modeline
set modelines=5

" Timeouts {{{2
set timeoutlen=500
set ttimeoutlen=20

" Shell {{{2
if has('mac')
  set shell=/opt/homebrew/bin/bash
elseif has('unix')
  set shell=/bin/bash
endif

" Font (GUI only) {{{2
if has('mac')
  set guifont=MesloLGS\ NF:h14
endif

" Window title {{{2
if $TERM_PROGRAM == "ghostty"
  set title
  set titlestring=%{fnamemodify(getcwd(),\ ':t')}
endif

" ==========================================================================
" Filetype & Syntax {{{1
" ==========================================================================

filetype plugin indent on
syntax on

" ==========================================================================
" Appearance {{{1
" ==========================================================================

" Colorscheme {{{2
if has('termguicolors')
  set termguicolors
endif

if &termguicolors
  silent! colorscheme gotham
else
  silent! colorscheme gotham256
endif

" Popup menu highlight overrides {{{2
function! s:ApplyPumHighlights() abort
  if &termguicolors
    hi Pmenu      guibg=#1f2430 guifg=#d0d0d0
    hi PmenuSel   guibg=#3a3f58 guifg=#ffffff gui=bold
    hi PmenuSbar  guibg=#2b3040
    hi PmenuThumb guibg=#606570
    hi WildMenu   guibg=#3a3f58 guifg=#ffffff
  else
    hi Pmenu      ctermbg=236 ctermfg=250
    hi PmenuSel   ctermbg=60  ctermfg=231 cterm=bold
    hi PmenuSbar  ctermbg=238
    hi PmenuThumb ctermbg=244
    hi WildMenu   ctermbg=60  ctermfg=231
  endif
endfunction

augroup MyThemeOverrides
  autocmd!
  autocmd ColorScheme * call s:ApplyPumHighlights()
augroup END

call s:ApplyPumHighlights()

" ==========================================================================
" Plugin Manager (minpac) {{{1
" ==========================================================================

" Bootstrap {{{2
let s:minpac_dir = expand('~/.vim/pack/minpac')
let s:minpac_opt = s:minpac_dir . '/opt/minpac'

if empty(glob(s:minpac_opt))
  silent! execute '!git clone --depth=1 https://github.com/k-takata/minpac.git ' . shellescape(s:minpac_opt)
  echom 'Bootstrapped minpac.'
endif

packadd minpac

" Plugin declarations {{{2
set rtp+=/opt/homebrew/opt/fzf

function! s:PackInit() abort
  call minpac#init()

  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Quality-of-life essentials
  call minpac#add('tpope/vim-sensible')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-commentary')

  " File explorer / git
  call minpac#add('preservim/nerdtree')
  call minpac#add('airblade/vim-gitgutter')

  " Colorschemes
  call minpac#add('rafi/awesome-vim-colorschemes')

  " Fuzzy finder
  call minpac#add('junegunn/fzf', {'do': '!./install --bin'})
  call minpac#add('junegunn/fzf.vim')

  " Python
  "call minpac#add('lambdalisue/vim-pyenv')

  " Statusline
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')

  " LSP
  call minpac#add('prabirshrestha/vim-lsp')
  call minpac#add('mattn/vim-lsp-settings')
  call minpac#add('prabirshrestha/asyncomplete.vim')
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
endfunction

" Management commands {{{2
command! -nargs=0 PackInit   call s:PackInit()
command! -nargs=0 PackUpdate call s:PackInit() | call minpac#update()
command! -nargs=0 PackClean  call s:PackInit() | call minpac#clean()
command! -nargs=0 PackStatus call s:PackInit() | call minpac#status()

" First-run hint {{{2
function! s:MinpacFirstRun() abort
  let start_glob = glob(s:minpac_dir . '/start/*', 1, 1)
  let opt_glob   = glob(s:minpac_opt . '/*',   1, 1)
  let opt_plugins = filter(copy(opt_glob), 'fnamemodify(v:val, ":t") !=# "minpac"')
  if empty(start_glob) && empty(opt_plugins)
    echo "Run :PackUpdate to install plugins"
  endif
endfunction

" ==========================================================================
" Plugin Configuration {{{1
" ==========================================================================

" Airline {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#pyenv#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline_theme = 'deus'

" fzf / ripgrep {{{2
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!.git"'
  command! -nargs=* -complete=file Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=never --smart-case --hidden -g "!.git" -- '.shellescape(<q-args>),
        \   1, fzf#vim#with_preview(), 0)
endif

" Pyenv {{{2
function! s:PyenvActivate(ver) abort
  if empty(a:ver)
    return
  endif
  if exists(':PyenvActivate')
    execute 'PyenvActivate ' . fnameescape(a:ver)
  else
    let $PYENV_VERSION = a:ver
  endif
  echo 'pyenv: ' . a:ver
endfunction

function! s:PyenvActivateFromFile() abort
  let l:file = findfile('.python-version', getcwd() . ';')
  if empty(l:file)
    return
  endif
  let l:ver = trim(join(readfile(l:file), ''))
  call s:PyenvActivate(l:ver)
endfunction

function! s:PyenvSelect() abort
  if !executable('pyenv')
    echohl ErrorMsg | echom 'pyenv not found' | echohl None
    return
  endif
  let l:list = split(system('pyenv versions --bare'), "\n")
  call filter(l:list, 'v:val =~# ''^\s*\S''')
  call fzf#run(fzf#wrap({
        \ 'source': l:list,
        \ 'sink*':  { lines -> s:PyenvActivate(get(lines, 0, '')) },
        \ 'options': '--prompt="pyenv> " --no-multi'
        \ }))
endfunction

" vim-lsp {{{2
" Diagnostics: signs in gutter + virtual text + echo on cursor hold (defaults).
let g:lsp_diagnostics_enabled                = 1
let g:lsp_diagnostics_signs_enabled          = 1
let g:lsp_diagnostics_virtual_text_enabled   = 1
let g:lsp_diagnostics_echo_cursor            = 1
let g:lsp_diagnostics_highlights_enabled     = 1
let g:lsp_document_highlight_enabled         = 1

" Sign markers for diagnostics
let g:lsp_diagnostics_signs_error       = {'text': '✗'}
let g:lsp_diagnostics_signs_warning     = {'text': '⚠'}
let g:lsp_diagnostics_signs_information = {'text': 'ℹ'}
let g:lsp_diagnostics_signs_hint        = {'text': '➤'}

" Cap synchronous format-on-save at 1s so saves never hang.
let g:lsp_format_sync_timeout = 1000

" Uncomment to enable verbose log file for debugging:
" let g:lsp_log_verbose = 1
" let g:lsp_log_file    = expand('~/vim-lsp.log')

" Default vim-lsp-settings install dir is $XDG_DATA_HOME/vim-lsp-settings/servers
" (~/.local/share/vim-lsp-settings/servers on Linux). Override with:
" let g:lsp_settings_servers_dir = expand('~/.local/share/vim-lsp-settings/servers')

" Per-buffer LSP setup runs only for buffers whose filetype has a registered server.
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nmap <buffer> gd          <plug>(lsp-definition)
  nmap <buffer> gD          <plug>(lsp-declaration)
  nmap <buffer> gi          <plug>(lsp-implementation)
  nmap <buffer> gt          <plug>(lsp-type-definition)
  nmap <buffer> gr          <plug>(lsp-references)
  nmap <buffer> gs          <plug>(lsp-document-symbol-search)
  nmap <buffer> gS          <plug>(lsp-workspace-symbol-search)
  nmap <buffer> K           <plug>(lsp-hover)
  nmap <buffer> [g          <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g          <plug>(lsp-next-diagnostic)
  nmap <buffer> <leader>rn  <plug>(lsp-rename)
  nmap <buffer> <leader>ca  <plug>(lsp-code-action)
  nmap <buffer> <leader>=   <plug>(lsp-document-format)
  vmap <buffer> <leader>=   <plug>(lsp-document-range-format)
endfunction

augroup LspBufferEnabled
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Format-on-save for filetypes whose LSP has a canonical formatter.
" Add filetypes here as you adopt their formatters (e.g. *.ts, *.py with ruff).
augroup LspFormatOnSave
  autocmd!
  autocmd BufWritePre *.go,*.rs,*.json call execute('LspDocumentFormatSync')
augroup END

" asyncomplete {{{2
let g:asyncomplete_auto_popup        = 1
let g:asyncomplete_auto_completeopt  = 0
set completeopt=menuone,noinsert,noselect,preview

" ==========================================================================
" Autocommands {{{1
" ==========================================================================

augroup VimrcFolds
  autocmd!
  autocmd BufReadPost,BufNewFile $MYVIMRC setlocal foldmethod=marker
augroup END

augroup LastPosition
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g'\"" | endif
augroup END

augroup FiletypeSettings
  autocmd!
  autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0 autoindent
augroup END

augroup NERDTreeAutoClose
  autocmd!
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

augroup SignColumnTweak
  autocmd!
  autocmd FileType nerdtree setlocal signcolumn=no
  autocmd FileType minpacprgs setlocal signcolumn=no
augroup END

augroup PyenvAuto
  autocmd!
  autocmd VimEnter,DirChanged * call s:PyenvActivateFromFile()
augroup END

augroup MinpacFirstRun
  autocmd!
  autocmd VimEnter * call s:MinpacFirstRun()
augroup END

" ==========================================================================
" Functions {{{1
" ==========================================================================

function! ToggleSignColumn() abort
  set number!
  set relativenumber!
  if &signcolumn ==# 'yes'
    set signcolumn=no
  else
    set signcolumn=yes
  endif
endfunction

" ==========================================================================
" Key Mappings {{{1
" ==========================================================================

" General toggles {{{2
nnoremap <silent> <leader>l   :set list!<CR>
nnoremap <silent> <leader>s   :set spell!<CR>
nnoremap <silent> <leader>o   :call ToggleSignColumn()<CR>
nnoremap <silent> <leader>nh  :noh<CR>
nnoremap          <leader>:   q:

" Vimrc management {{{2
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" fzf / search {{{2
nnoremap <silent> <leader>f   :Files<CR>
nnoremap <silent> <leader>b   :Buffers<CR>
nnoremap <silent> <leader>g   :GFiles?<CR>
nnoremap <silent> <leader>fl  :Lines<CR>
nnoremap <silent> <leader>fb  :BLines<CR>
nnoremap <silent> <leader>fc  :Commits<CR>
nnoremap <silent> <leader>fw  :Windows<CR>
nnoremap <silent> <leader>fk  :Marks<CR>
nnoremap <silent> <leader>ft  :Filetypes<CR>
nnoremap <silent> <leader>co  :Colors<CR>
nnoremap          <leader>r   :Rg<Space>
nnoremap <silent> <leader>cm  :Commands<CR>
nnoremap <silent> <leader>hs  :History<CR>
nnoremap <silent> <leader>hh  :Helptags<CR>
nnoremap <silent> <leader>hm  :Maps<CR>

" NERDTree {{{2
nnoremap <silent> <leader>e   :NERDTreeToggle<CR>
nnoremap <silent> <leader>ef  :NERDTreeFind<CR>

" Git (gitgutter) {{{2
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gd <Plug>(GitGutterPreviewHunk)

" Comments (vim-commentary) {{{2
nnoremap <silent> <leader>/  :Commentary<CR>
xnoremap <silent> <leader>/  :Commentary<CR>

" Pyenv {{{2
nnoremap <silent> <leader>pa :call <SID>PyenvSelect()<CR>
nnoremap <silent> <leader>pd :PyenvDeactivate<CR>

" Plugin management (minpac) {{{2
nnoremap <silent> <leader>u  :PackUpdate<CR>
nnoremap <silent> <leader>c  :PackClean<CR>
nnoremap <silent> <leader>ps :PackStatus<CR>

" Command-line popup menu {{{2
cnoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<C-z>"
cnoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
cnoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
cnoremap <expr> <Esc>   pumvisible() ? "\<C-e>" : "\<Esc>"

" Insert-mode completion popup (asyncomplete) {{{2
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
