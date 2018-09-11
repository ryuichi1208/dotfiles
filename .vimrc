syntax on

set ignorecase
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）
set wrapscan

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

set shiftround
set infercase
set hidden
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set title               "編集中のファイル名を表示
set tabstop=4           "インデントをスペース4つ分に設定
set softtabstop=4       "オートインデント後のスペース
set smartindent         "オートインデント
set expandtab
set autoindent
set shiftwidth=4
set matchpairs& matchpairs+=<:> " 対応括弧に'<'と'>'のペアを追加
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする

set mouse-=a

set nowritebackup
set nobackup
set noswapfile

set list
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set t_vb=
set novisualbell


