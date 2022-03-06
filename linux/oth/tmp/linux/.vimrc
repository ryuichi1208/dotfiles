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
" Plugin dein.vim
"----------------------------------------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/.repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.')
  call dein#begin('~/.')

  " Let dein manage dein
  " Required:
  call dein#add('airblade/vim-gitgutter')
  call dein#add('basyura/TweetVim')
  call dein#add('chase/vim-ansible-yaml')
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('kien/ctrlp.vim')
  call dein#add('Lokaltog/vim-powerline')
  call dein#add('majutsushi/tagbar')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('scrooloose/nerdtree')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('skanehira/translate.vim')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('thinca/vim-quickrun')
  call dein#add('tpope/vim-commentary')
  call dein#add('w0rp/ale')

  " NERDTree
  call dein#add('scrooloose/nerdtree')
  call dein#add('jistr/vim-nerdtree-tabs')

  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')

  " C/C++
  call dein#add('justmao945/vim-clang')
  call dein#add('Shougo/neoinclude.vim')

  " Perl
  call dein#add('c9s/perlomni.vim')
  call dein#add('vim-perl/vim-perl')

  " 補完/スニペット
  " Markdorwn
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')

  " 補完/スニペット
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')

  " LSP関連
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')

  " ドキュメント系
  call dein#add('reireias/vim-cheatsheet')
  call dein#add('skanehira/translate.vim')
  call dein#add('vim-jp/vimdoc-ja')

  " 未使用
  "call dein#add('davidhalter/jedi-vim')
  "call dein#add('kevinw/pyflakes-vim')
  "call dein#add('prettier/vim-prettier')
  "call dein#add('scrooloose/syntastic')
  "call dein#add('Shougo/neocomplcache')
  "call dein#add('vim-airline/vim-airline')
  "call dein#add('vim-airline/vim-airline-themes')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to jnstall not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"----------------------------------------------------------
" Lokaltog/vim-powerline
"----------------------------------------------------------
set laststatus=2
set showtabline=2
set noshowmode
set t_Co=256
set guioptions-=e

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ,
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


"----------------------------------------------------------
" Shougo/neocomplete.vim
"----------------------------------------------------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"


"----------------------------------------------------------
" justmao945/vim-clang
"----------------------------------------------------------
"let g:clang_auto = 0
"let g:clang_complete_auto = 0
"let g:clang_auto_select = 0
"let g:clang_use_library = 1
" default 'longest' can not work with neocomplete
"let g:clang_c_completeopt   = 'menuone'
"let g:clang_cpp_completeopt = 'menuone'
"let g:clang_exec = 'clang'
"let g:clang_format_exec = 'clang-format'
"let g:clang_c_options = '-std=c11'
"let g:clang_cpp_options = '
"  \ -std=c++1z
"  \ -stdlib=libc++
"  \ -pedantic-errors
"  \ '


"----------------------------------------------------------
" vim-airline
"----------------------------------------------------------
" 1 ページあたりのツイート取得件数
let g:tweetvim_tweet_per_page = 50
" 表示内容をキャッシュしておく数(バッファを戻る、進むに使用)
let g:tweetvim_cache_size     = 10
" 設定情報を保存するディレクトリ
let g:tweetvim_config_dir     = expand('~/.tweetvim')
" タイムラインにリツイートを含める
let g:tweetvim_include_rts    = 1
" source(クライアント名) を表示するオプション
let g:tweetvim_display_source = 1
" ツイート時間の表示・非表示設定 (少しでも表示時間を速くしたい場合)"
let g:tweetvim_display_time   = 1
" タイムラインを開く際のコマンドを指定 (edit/split/vsplit)"
let g:tweetvim_open_buffer_cmd = 'edit!'
" 発言用のバッファを開く際のコマンドを指定
let g:tweetvim_open_say_cmd = 'botright split'
" アイコン表示 (ImageMagick が必要)
let g:tweetvim_display_icon = 1
" tweetvim_say バッファを開いた際にフッタ(メッセージ)を表示する
let g:tweetvim_footer = ''
" tweetvim_say バッファにアカウント名を差し込む
let g:tweetvim_display_separator = 1
" 空文字セパレータを表示
let g:tweetvim_empty_separator = 0
" To modify the tweet length do:
let g:tweetvim_tweet_limit = 280
"let g:clang_c_options = '-std=c11'
"let g:clang_cpp_options = '
"  \ -std=c++1z
"  \ -stdlib=libc++
"  \ -pedantic-errors
"  \ '

"----------------------------------------------------------
" vim-airline
"----------------------------------------------------------
"let g:airline_theme = 'molokai'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"nmap <C-p> <Plug>AirlineSelectPrevTab
"nmap <C-n> <Plug>AirlineSelectNextTab


"----------------------------------------------------------
" junegunn/vim-easy-align
"----------------------------------------------------------
" EasyAlignを開始
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


"----------------------------------------------------------
" jistr/vim-nerdtree-tabs
"----------------------------------------------------------
"let g:NERDTreeShowBookmarks=1
"let NERDTreeShowHidden = 1
"let g:nerdtree_tabs_open_on_console_startup=1

nnoremap <silent><C-e> :NERDTreeTabsToggle<CR>
"autocmd vimenter * NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')


"----------------------------------------------------------
" vim-table-mode
"----------------------------------------------------------
let g:table_mode_corner = '|'


"----------------------------------------------------------
" Gitgutter
"----------------------------------------------------------
" タイピング停止時から反映されるまでの時間
set updatetime=200
" 最初から表示領域を確保
set signcolumn=yes
" 記号表示領域の背景色
let g:gitgutter_override_sign_column_highlight = 0
highlight GitGutterAdd ctermfg=blue ctermbg=brown


"----------------------------------------------------------
" vim-cheatsheet
"----------------------------------------------------------
let g:cheatsheet#cheat_file = '~/.vim/.cheatsheet.md'


"----------------------------------------------------------
" scrooloose/nerdcommenter
"----------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


"----------------------------------------------------------
" quickrun.vim
"----------------------------------------------------------
set splitbelow
nmap <Leader>r <plug>(quickrun)
let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config._ = {
\   'outputter/buffer/split': '10'
\ }


"----------------------------------------------------------
" w0rp/ale
"----------------------------------------------------------
" 保存時のみ実行する
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_column_always = 1
" シンボルの変更
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
" エラー間移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_open_list = 1
" エラーと警告がなくなっても開いたままにする
let g:ale_keep_list_window_open = 1


"----------------------------------------------------------
" prettier/vim-prettier
"----------------------------------------------------------
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'python': ['prettier']
      \ }

"let g:ale_fix_on_save = 1
"let g:ale_javascript_prettier_use_local_config = 1


"----------------------------------------------------------
" scrooloose/syntastic
"----------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


"----------------------------------------------------------
" vim-perl/vim-perl
"----------------------------------------------------------
augroup filetypedetect
    au BufNewFile,BufRead *.psgi    setf perl
    au BufNewFile,BufRead *.t       setf perl
    au BufNewFile,BufRead *.tt      setf tt2html
    au BufNewFile,BufRead *.tt2     setf tt2html
    au BufNewFile,BufRead cpanfile  setf perl
augroup END


"----------------------------------------------------------
" skanehira/translate.vim
"----------------------------------------------------------
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_winsize = 10


"----------------------------------------------------------
" prabirshrestha/vim-lsp
"----------------------------------------------------------
" デバッグ用設定
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')

" 言語用Serverの設定
augroup MyLsp
  autocmd!
  " pip install python-language-server
  if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'pycodestyle': {'enabled': v:false},
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif
augroup END
function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete
  nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
  nnoremap <buffer> gd :<C-u>LspDefinition<CR>
  nnoremap <buffer> gD :<C-u>LspReferences<CR>
  nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
  nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction
let g:lsp_diagnostics_enabled = 0


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

" シンタックスを有効にする
syntax on
colorscheme molokai
"colorscheme koehler
"set background=dark

" ターミナル接続を高速化
set ttyfast

" 改行時自動インデント
set smartindent

" 行番号を表示
set number

" 不可視文字を表示
"set list

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


" ----------------------------------------------------------
" Keymap
"----------------------------------------------------------
" :map   :noremap  :unmap     ノーマル、ビジュアル、選択、オペレータ待機
" :nmap  :nnoremap :nunmap    ノーマル
" :vmap  :vnoremap :vunmap    ビジュアル、選択
" :smap  :snoremap :sunmap    選択
" :xmap  :xnoremap :xunmap    ビジュアル
" :map!  :noremap! :unmap!    挿入、コマンドライン
" :imap  :inoremap :iunmap    挿入
" :lmap  :lnoremap :lunmap    挿入、コマンドライン、Lang-Arg
" :cmap  :cnoremap :cunmap    コマンドライン

"インサートモードでも移動
inoremap <c-d> <Del>
inoremap <c-j> <down>
"inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 新規タブ
nnoremap st :<C-u>tabnew<CR>

" 垂直分割
nnoremap sv :<C-u>vs<CR>

" 水平分割
nnoremap ss :<C-u>sp<CR>

" 分割移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" w!! でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" quickfix
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ
autocmd QuickFixCmdPost *grep* cwindow

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

" Leader
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>t gt
nnoremap <Leader>T gT
nnoremap <Leader>h ^
nnoremap <Leader>l $
