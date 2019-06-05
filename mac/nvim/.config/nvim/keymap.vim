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

" gitgutter
nnoremap [gitgutter] <Nop>
nmap <C-h> [gitgutter]
nmap [gitgutter]j <Plug>GitGutterNextHunk
nmap [gitgutter]k <Plug>GitGutterPrevHunk
nmap [gitgutter]u <Plug>GitGutterUndoHunk

" anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

" pumvisible
inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"

" quickrun
nmap <Leader>r <plug>(quickrun)

" Nerd
nnoremap <silent><C-e> :NERDTreeTabsToggle<CR>

noremap ZZ <Nop>
noremap ZQ <Nop>
noremap <C-z> <Nop>
noremap <F1> <Nop>
