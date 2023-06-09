set clipboard=unnamedplus

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/ryuichi/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/ryuichi/.cache/dein')
  call dein#begin('/home/ryuichi/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/ryuichi/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
   call dein#install()
endif

"End dein Scripts-------------------------

"----------------------------------------------------------
"" Encoding
"----------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
scriptencoding utf-8

"----------------------------------------------------------
"" release autogroup in MyAutoCmd
"----------------------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END


"インサートモードでも移動
inoremap <C-d> <Del>
inoremap <c-k> <up>
inoremap <c-j> <down>
inoremap <c-h> <left>
inoremap <c-l> <right>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 括弧の補完追加
inoremap < <><LEFT>
"
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
"
" w!! でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %
"
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
"
" 全角を半角へ
inoremap 　 <Space>
inoremap ｜ \|
inoremap ＜ <
inoremap ＞ >
inoremap ＊ *
inoremap ＠ @
inoremap ％ %
inoremap ＃ #
inoremap ” "
inoremap ’ '
inoremap ＋ +
inoremap ～ ~
inoremap ０ 0
inoremap １ 1
inoremap ２ 2
inoremap ３ 3
inoremap ４ 4
inoremap ５ 5
inoremap ６ 6
inoremap ７ 7
inoremap ８ 8
inoremap ９ 9

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
colorscheme molokai

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

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" 正規表現
nnoremap / /\v
nnoremap ? ?\v

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
  autocmd FileType bash       setlocal sw=4 sts=4 ts=4 et
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
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json       setlocal sw=2 sts=2 ts=2 et

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

augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" ========================
" Delete mapping
" ========================
noremap ZZ <Nop>
noremap ZQ <Nop>
noremap <C-z> <Nop>
noremap <F1> <Nop>


" ========================
" Pumvisible
" ========================
inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"


" ========================
" Leader config
" ========================
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>t gT
nnoremap <Leader>h ^
nnoremap <Leader>l $


" ========================
" Tab config
" ========================
" 分割移動
nnoremap ss :<C-u>sp<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap    [Tag]   <Nop>
nmap    t [Tag]
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>
au FileType qf nnoremap <silent><buffer>q :quit<CR>


" ========================
" quickfix
" ========================
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
autocmd QuickFixCmdPost *grep* cwindow


" ========================
" scrooloose/nerdtree
" ========================
nnoremap <silent><C-n> :NERDTreeTabsToggle<CR>


" ========================
" thinca/vim-quickrun
" ========================
nmap <Leader>e <plug>(quickrun)
au FileType qf nnoremap <silent><buffer>q :quit<CR>


" ========================
" junegunn/fzf
" ========================
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,F :GFiles?<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,m :Mark<CR>

" ========================
" fatih/vim-go
" ========================
augroup go
  autocmd!
  autocmd FileType go nmap <silent> <Leader>d   <Plug>(go-def-tab)
  autocmd FileType go nmap <silent> <Leader>x   <Plug>(go-doc-vertical)
  autocmd FileType go nmap <silent> <Leader>i   <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>L   <Plug>(go-metalinter)
  autocmd FileType go nmap <silent> <leader>T   <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>I   <Plug>(go-install)
  autocmd FileType go nmap <silent> <Leader>c   <Plug>(go-coverage-toggle)

  autocmd FileType go nmap <silent> <leader>[   :GoDef<CR>
  autocmd FileType go nmap <silent> <leader>R   :GoReferrers<CR>
  autocmd FileType go nmap <silent> <leader>fs  :GoFillStruct<CR>
  autocmd FileType go nmap <silent> <leader>ei  :GoIfErr<CR>
  autocmd FileType go nmap <silent> <leader>ki  :GoKeyify<CR>
  autocmd FileType go nmap <silent> <leader>dd  :GoDeclsDir<CR>
  autocmd FileType go nmap <silent> <leader>ip  :GoImpl<CR>
augroup END


" ========================
" machakann/vim-swap
" ========================
nmap <Leader>o <Plug>(swap-interactive)
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)


" ========================
" osyo-manga/vim-anzu
" ========================
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)


" ========================
" airblade/vim-gitgutter
" ========================
nnoremap [gitgutter] <Nop>
nmap <C-h> [gitgutter]
nmap [gitgutter]j <Plug>GitGutterNextHunk
nmap [gitgutter]k <Plug>GitGutterPrevHunk
nmap [gitgutter]u <Plug>GitGutterUndoHunk


" ========================
" rhysd/vim-clang-format
" ========================
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>


" ========================
" neoclide/coc.nvim
" ========================
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" ========================
" tpope/vim-fugitive
" ========================
nnoremap [fugitive]  <Nop>
nmap <space>f [fugitive]
nnoremap <silent> [fugitive]s :Gstatus<CR><C-w>T
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]c :Gcommit-v<CR>
nnoremap <silent> [fugitive]b :Gblame<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]m :Gmerge<CR>
