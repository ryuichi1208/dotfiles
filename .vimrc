"################
" Character code
"################
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double
set fileencoding=UTF-8
set termencoding=UTF-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

"################
" Setting
"################
set nobackup
set noswapfile
set autoread
"set iminsert=2
set hidden
"set visualbell
"set mouse=a
set autoindent
"set smartindent
"set laststatus=2
set ttyfast
"set spell
set list
"set expandtab
set history=100
set wildmenu
set ignorecase
set smartcase
set incsearch
set wrapscan
set gdefault
set hlsearch
"set backup
"set backupdir=~/backup
set showcmd
set showmatch

"#################
" Appearance
"#################
set title
set number
set cursorline
"set cursorcolumn
set nolist
set runtimepath+=~/.vim_color
colorscheme molokai
syntax on
set ruler
"autocmd ColorScheme * highlight LineNr ctermfg=210
"autocmd highlight CursorLine ctermbg=230
"colorscheme darkblue
"colorscheme default

"#################
" key map
"#################
inoremap jj <Esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nmap <Esc><Esc> :nohlsearch<CR><Esc>
imap <C-k> <Up>
imap <C-j> <Down>
"imap <C-h> <Left>
"imap <C-l> <Right>
nnoremap + <C-a>
nnoremap - <C-x>
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-l> <c-w>l
"nnoremap <c-h> <c-w>h
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" The last position saved
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
    augroup END

    " Delete blank space at end of line
    autocmd BufWritePre * :%s/\s\+$//ge

    " Em Space Print
    highlight EmSpace cterm=underline ctermfg=100
    match EmSpace /　/

