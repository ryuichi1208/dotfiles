" ---------------------------------------------------------
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

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" w!! でスーパーユーザーとして保存
cmap w!! w !sudo tee > /dev/null %

" 正規表現
nnoremap / /\v
nnoremap ? ?\v

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" vimgrep用のキーマップ
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

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

map <silent> [Tag]y :tablast <bar> tabnew<CR>
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
nnoremap <silent> z :Files<CR>
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


" ========================
" easymotion/vim-easymotion
" ========================
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap <Leader>m <Plug>(easymotion-sn)
xmap <Leader>m <Plug>(easymotion-sn)
omap <Leader>m <Plug>(easymotion-tn)
