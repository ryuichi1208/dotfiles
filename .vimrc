syntax on

set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

set shiftround
set infercase
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3
set title
set tabstop=4
set softtabstop=4
set smartindent
set expandtab
set autoindent
set shiftwidth=4
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start

set mouse-=a

set nowritebackup
set nobackup
set noswapfile

set list
set number
set wrap
set t_vb=
set novisualbell


