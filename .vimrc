" ========== Plugin Setting =======


" ========== Character code =======
" 文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
set fileformat=unix

" ========== Base Config ==========
" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" バッファが編集中でもその他のファイルを開けるように
set hidden

" シンタックスを有効にする
syntax on
colorscheme molokai

" 改行時自動インデント
set smartindent

" 行番号を表示
set number

" インクリメントサーチを有効にする
set incsearch

" ハイライトサーチを有効にする
set hlsearch

" 検索時大文字小文字を区別しない
set ignorecase

" 検索時に大文字を入力した場合ignorecaseが無効になる
set smartcase

" カーソルラインを表示する
set cursorline

" ファイル更新で自動で読み直す
"set autoread

" ビープ音を可視化
"set visualbell

" 括弧入力時の対応する括弧を表示
set showmatch

" ステータスラインを常に表示
set laststatus=1

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" タイトルを表示
set title

" カーソルの行数表示
set cursorline

" カーソルから相対的な行数を表示する
""set relativenumber

" マウス操作を有効にする
""set mouse=a

" 1 tab == 4 spaces
""set shiftwidth=4
""set tabstop=4

" タイムアウト時間設定
set timeout timeoutlen=1000 ttimeoutlen=50

" ========== Key Map ==============

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 折り返しでも行単位で移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
