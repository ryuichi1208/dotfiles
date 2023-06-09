augroup emmet
  au!
  au FileType vue,html,javascript,css EmmetInstall
  au FileType vue,html,javascript,css imap <buffer> <C-f> <plug>(emmet-expand-abbr)
augroup END
" }}}

" vim-vue {{{
" https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
" vueファイルのシンタックスが効かなくなる問題対応
augroup VueSyntax
  au!
  au FileType vue syntax sync fromstart
augroup END
" }}}

" sonictemplate.vim {{{
let g:sonictemplate_author = 'skanehira'
let g:sonictemplate_license = 'MIT'
let g:sonictemplate_vim_template_dir = expand('~/.vim/sonictemplate')
imap <silent> <C-l> <plug>(sonictemplate-postfix)
" }}}

" vimhelpgenarator {{{
let g:vimhelpgenerator_version = ''
let g:vimhelpgenerator_author = 'Author: skanehira <sho19921005@gmail.com>'
let g:vimhelpgenerator_uri = 'https://github.com/skanehira/'
let g:vimhelpgenerator_defaultlanguage = 'en'
" }}}

" {{{ MemoList
let g:memolist_fzf = 1
" }}}

" {{{ lexima
let g:lexima_enable_basic_rules = 1
" }}}

" {{{ docker.vim
let g:docker_terminal_open = 'vert'
"let s:docker_auth_file = expand('~/.docker/docker.vim.json')
"let g:docker_registry_auth = json_decode(join(readfile(s:docker_auth_file), "\n"))
" }}}

" {{{ preview.vim
let g:previm_open_cmd = 'open'
" }}}

" {{{ gofmtmd
let g:gofmtmd_auto_fmt = 0
" }}}

" {{{ preview-markdown.vim
let g:preview_markdown_vertical = 1
let g:preview_markdown_auto_update = 1
let g:preview_markdown_parser = 'mdr'
" }}}

" {{{ vista
let g:vista_default_executive = 'vim_lsp'
" }}}

"{{{ gist-vim
let g:gist_post_private = 1
let g:gist_list_vsplit = 1
"}}}

" {{{ 自作関数

" {{{ w3m
function! s:gg(package) abort
  execute('term ++close ++shell w3m pkg.go.dev/' . a:package)
endfunction

command! -nargs=1 GG call s:gg(<f-args>)

function! s:www(word) abort
  execute('term ++close ++shell w3m google.com/search\?q="' . a:word . '"')
endfunction

command! -nargs=1 WWW call s:www(<f-args>)
" }}}

" {{{ リポジトリに移動
function! s:cd_repo(shell, repo) abort
  exe 'lcd' trim(system('ghq root')) .. '/' .. a:repo
  pwd
endfunction

function! s:repo(cb) abort
  if executable('ghq') && exists('*fzf#run()') && executable('fzf')
    call fzf#run({
          \ 'source': systemlist('ghq list'),
          \ 'sink': a:cb,
          \ 'down': '40%'},
          \ )
  else
    echo "doesn't installed ghq or fzf.vim(require fzf)"
  endif
endfunction

command! Repo call s:repo(function('s:cd_repo', [&shell]))
" }}}

" 新しいタブを開く {{{
function! s:open_tabs(shell, repo) abort
  exe printf('tabnew | lcd %s/%s', trim(system('ghq root')), a:repo)
endfunction

" fzf.vimのcallbackでは&shellがshになってしまうので、現在実行しているshellを渡す
command! Repot call s:repo(function('s:open_tabs', [&shell]))

" }}}

" {{{ エラーメッセージ出力
function! s:echo_err(message) abort
  echohl ErrorMsg
  redraw
  echo a:message
  echohl None
endfunction
" }}}

" {{{ gitコマンド関連
" options:
" {
"	cmd: 'diff'
"	args: [
"		'HEAD^',
"	],
"	auto_close: 0,	" 1: true, 0: false
"	window_way: 'bo',	" tab, bo, vert, term, etc...
"	mode: 'term', " term, popup, fzf
"	focus: 1008, " window id
"	source: [], " fzf source
"	cb: functionm "fzf callback
" }
function! s:git_exec(opt) abort
  let current_winid = win_getid()
  if a:opt.mode is# 'term'
    let cmd = 'git ' .. a:opt.cmd
    if has_key(a:opt, 'args') && !empty(a:opt.args)
      let cmd = cmd .. ' ' .. join(a:opt.args, ' ')
    endif
    if has_key(a:opt, 'auto_close') && a:opt.auto_close is# 1
      let cmd = a:opt.window_way .. ' term ++rows=10 ++close ' .. cmd
    else
      let cmd = a:opt.window_way .. ' term ++rows=10 ' .. cmd
    endif
    exec cmd
    nnoremap <buffer> <silent> q :bw!<CR>
  elseif a:opt.mode is# 'pop'
    " TODO use popup window
  elseif a:opt.mode is# 'fzf'
    if exists('*fzf#run()') && executable('fzf')
      call fzf#run({
            \ 'source': a:opt.source,
            \ 'sink': a:opt.cb,
            \ 'down': '40%'},
            \ )
    endif
  else
    call s:echo_err("doesn't installed fzf.vim(require fzf)")
  endif

  call win_gotoid(current_winid)
endfunction

function! s:git_log() abort
  " use fish command
  call system('tmux new-window git log')
endfunction

function! s:git_push(...) abort
  let opt = {
        \ 'cmd': 'push',
        \ 'args': a:000,
        \ 'auto_close': 1,
        \ 'window_way': 'top',
        \ 'mode': 'term',
        \ }

  call s:git_exec(opt)
endfunction

function! s:git_pull(...) abort
  let opt = {
        \ 'cmd': 'pull',
        \ 'args': a:000,
        \ 'auto_close': 1,
        \ 'window_way': 'top',
        \ 'mode': 'term',
        \ }

  call s:git_exec(opt)
endfunction

function! s:git_checkout_cb(repo) abort
  call system('git checkout' .. a:repo)
endfunction

function! s:git_checkout(...) abort
  let source = filter(systemlist('git branch'), 'v:val[0] isnot# "*"')
  if empty(source)
    call s:echo_err("no other branch")
    return
  endif

  let opt = {
        \ 'source': source,
        \ 'mode': 'fzf',
        \ 'cb': function('s:git_checkout_cb'),
        \ }

  call s:git_exec(opt)
endfunction

command! -nargs=* Gitpush call s:git_push(<f-args>)
command! -nargs=* Gitpull call s:git_pull()
command! -nargs=* GitCheckout call s:git_checkout(<f-args>)
nnoremap <silent> gc :GitCheckout<CR>

" }}}

" {{{ バッファ関連
function! s:buflist() abort
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:format_buffer(b)
  let name = bufname(a:b)
  let name = empty(name) ? '[No Name]' : fnamemodify(name, ":p:~:.")
  let flag = a:b == bufnr('')  ? '%' : a:b == bufnr('#') ? '#' : ' '
  let modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
  let readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
  let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
  return printf("[%s] %s\t%s\t%s", a:b, flag, name, extra)
endfunction

function! s:delbuf(buf) abort
  exe 'bw!' a:buf[match(a:buf, '[')+1:match(a:buf, ']')-1]
endfunction

function! s:delbuflist() abort
  call fzf#run({
        \ 'source': map(copy(s:buflist()), 's:format_buffer(v:val)'),
        \ 'sink': function('s:delbuf'),
        \ 'options': "-m",
        \ 'down': '40%'},
        \ )
endfunction

command! DelBuf call s:delbuflist()
" }}}

" {{{ ディレクトリ自動生成
augroup vimrc-auto-mkdir
  au!
  au BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
" }}}

" }}}

" vim: foldmethod=marker
