"----------------------------------------------------------
" basic
"----------------------------------------------------------
set laststatus=2
set showtabline=2
set noshowmode
set t_Co=256
set guioptions-=e

" 改行コードの自動判別
set fileformat=unix

" □や○文字が崩れる問題を解決
set ambiwidth=double

" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile
"set directory=~/.vim/swap/

" バッファが編集中でもその他のファイルを開けるように
set hidden

" シンタックスを有効にする
syntax on
"colorscheme molokai
colorscheme glubox
hi Comment ctermfg=138

if &term == "xterm-256color"
    " hi Comment ctermfg=102
    " hi Visual  ctermbg=236
endif

" ターミナル接続を高速化
set ttyfast

" 改行時自動インデント
set smartindent

" 行番号を表示
set number
set relativenumber

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
set cursorcolumn

" ファイル更新で自動で読み直す
set autoread

" 補完ウィンドウの設定
set completeopt=menuone

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応括弧の表示秒数を3秒にする
set matchtime=5

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" タイトルを表示
set title

" 改行コードの自動認識
set fileformats=unix,mac,dos

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

" 検索位置が何番目かを表示
set shortmess-=S

" タイピング停止時から反映されるまでの時間
set updatetime=200

" 最初から表示領域を確保
set signcolumn=yes

" ウィンドウを開く方向を指定
set splitbelow

" 開業などをみやすく
set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" Auto comment out disable
autocmd Filetype * set formatoptions-=r

" 前回のカーソル位置へ戻る
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
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


" CursorLine
hi clear CursorLine
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  setlocal cursorline
  hi clear CursorLine

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      hi CursorLine term=underline cterm=underline guibg=Grey90 " ADD
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
      hi clear CursorLine " ADD
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          " setlocal nocursorline
          hi clear CursorLine " ADD
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      " setlocal cursorline
      hi CursorLine term=underline cterm=underline guibg=Grey90 " ADD
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" Ansible
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
augroup ansible_vim_fthosts
  autocmd!
  autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
augroup END

if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
