"----------------------------------------------------------
" Encoding
"----------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
scriptencoding utf-8


"----------------------------------------------------------
" release autogroup in MyAutoCmd
"----------------------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END


"----------------------------------------------------------
" basic
"----------------------------------------------------------
" 改行コードの自動判別
set fileformat=unix

" □や○文字が崩れる問題を解決
set ambiwidth=double

" バックアップファイルを作らない
set nobackup
"set backupdir=~/.vim/backup/

" スワップファイルを作らない
set noswapfile
"set directory=~/.vim/swap/

" バッファが編集中でもその他のファイルを開けるように
set hidden

" ターミナル接続を高速化
set ttyfast

" 改行時自動インデント
set smartindent

" 行番号を表示
set number

" マルチバイト文字があってもカーソルがずれないようにする
set ambiwidth=double

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
set autoread

" 補完ウィンドウの設定
set completeopt=menuone

" ビープ音を可視化
"set visualbell

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応括弧の表示秒数を3秒にする
set matchtime=5

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" タイトルを表示
set title

" カーソルの行数表示
set cursorline
"set cursorcolumn

" Show column
"set colorcolumn=80

" カーソルから相対的な行数を表示する
"set relativenumber

" 改行コードの自動認識
set fileformats=unix,mac,dos

" マウス操作を有効にする
"set mouse=a

" タイムアウト時間設定
set timeout timeoutlen=1000 ttimeoutlen=50

" wildmenuを有効にする
set wildmenu
set wildmode=full

" 保存するコマンド履歴の数
set history=500

" バックスペースキーの有効化
set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" スクリーンベルを無効化
set t_vb=
set novisualbell

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" コメント文の色を変更
"highlight Comment ctermfg=DarkCyan

" 検索位置が何番目かを表示
set shortmess-=S

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" Auto comment out disable
autocmd Filetype * set formatoptions-=r

" 前回のカーソル位置へ戻る
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" INDENT
augroup fileTypeIndent
  autocmd!
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go         setlocal sw=8 sts=8 ts=8 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=4 sts=4 ts=4 et
  autocmd FileType markdown   setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType rust       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et

  autocmd FileType perl,cgi   compiler perl
  autocmd FileType python     setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType ruby       compiler ruby
  autocmd FileType go         setlocal noexpandtab
augroup END

" 行末のスペースをハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" Auto close quickfix
augroup QfAutoCommands
  autocmd!
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END
