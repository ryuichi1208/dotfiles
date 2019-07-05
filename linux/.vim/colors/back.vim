let $DEIN_BASE = expand('~/.local/share/vim/dein')
let $DEIN_REPOS_DIR = expand('$DEIN_BASE/repos/github.com/Shougo/dein.vim')
if !isdirectory($DEIN_REPOS_DIR)
  if !executable('git')
    echo 'Please install git.'
    finish
  endif
  call mkdir(fnamemodify($DEIN_REPOS_DIR, ':h'), 'p')
  call system('git clone https://github.com/Shougo/dein.vim.git ' .
  \   shellescape($DEIN_REPOS_DIR))
  if !isdirectory($DEIN_REPOS_DIR)
    echo 'dein install failed.'
    finish
  endif
endif
set runtimepath^=$DEIN_REPOS_DIR

let g:dein#enable_name_conversion = 1

function! s:update_cmpl(lead, line, pos) abort
  return filter(keys(dein#get()), 'v:val =~# "^" . a:lead')
endfunction
function! s:source_cmpl(lead, line, pos) abort
  return keys(filter(dein#get(), 'v:key =~# "^" . a:lead && !v:val.sourced'))
endfunction
command! -nargs=* -complete=customlist,s:update_cmpl DeinUpdate
\   try
\ |   let s:updatetime = &updatetime
\ |   let &updatetime = 50
\ |   call call('dein#update', [<f-args>])
\ | finally
\ |   let &updatetime = s:updatetime
\ | endtry
command! -nargs=* -complete=customlist,s:update_cmpl DeinReinstall
\   call call('dein#reinstall', [<f-args>])
command! -nargs=+ -complete=customlist,s:source_cmpl DeinSource
\   call call('dein#source', [<f-args>])
command! DeinRecache call dein#recache_runtimepath()

if !dein#load_state($DEIN_BASE)
  finish
endif

call dein#begin($DEIN_BASE, [expand('<sfile>')])

if $DROPBOX_HOME !=# ''
  call dein#local($DROPBOX_HOME . '/work/vim-plugins/labs', {'frozen': 1})
endif

call dein#add('Shougo/dein.vim')

function! s:try(cmd) abort
  try
    execute a:cmd
    return 1
  catch
    return 0
  endtry
endfunction

let s:use_deoplete = has('python3') && s:try('python3 import neovim')
call dein#add('Shougo/deoplete.nvim', {'if': s:use_deoplete})
call dein#add('roxma/nvim-yarp', {'if': s:use_deoplete})
call dein#add('roxma/vim-hug-neovim-rpc', {'if': s:use_deoplete})
call dein#add('Shougo/neocomplete.vim', {'if': has('lua')})
call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/vimproc.vim', {
\ 'build':
\   has('mac') ? 'make -f make_mac.mak' :
\   has('unix') ? 'make' : ''
\ })
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/unite-build')
call dein#add('Shougo/vinarise.vim')
call dein#add('Shougo/echodoc', {'lazy': 1})
call dein#add('Shougo/unite-session', {'lazy': 1})
call dein#add('Shougo/unite-outline')

call dein#add('AndrewRadev/linediff.vim')
call dein#add('AndrewRadev/sideways.vim')
call dein#add('vim-scripts/CSApprox', {'lazy': 1})
call dein#add('vim-scripts/Colour-Sampler-Pack', {'lazy': 1})
call dein#add('LeafCage/yankround.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('Rykka/colorv.vim', {'lazy': 1})
" call dein#add('anyakichi/vim-surround')
call dein#add('basyura/J6uil.vim', {'lazy': 1})
call dein#add('basyura/TweetVim')
call dein#add('basyura/bitly.vim')
call dein#add('basyura/twibill.vim')
call dein#add('basyura/unite-rails')
call dein#add('cohama/lexima.vim', {'on_i': 1})
call dein#add('bootleq/vim-cycle', {'lazy': 1})
call dein#add('deris/vim-duzzle', {'on_cmd': 'DuzzleStart'})
call dein#add('deris/vim-operator-insert')
call dein#add('deris/vim-rengbang')
call dein#add('dietsche/vim-lastplace')
call dein#add('eagletmt/onlinejudge-vim', {'lazy': 1})
call dein#add('emanon001/fclojure.vim', {'lazy': 1})
" call dein#add('vim-scripts/errormarker.vim')
" call dein#add('h1mesuke/unite-outline')
call dein#add('h1mesuke/vim-alignta')
call dein#add('h1mesuke/vim-benchmark')
call dein#add('haya14busa/vim-asterisk')
call dein#add('haya14busa/vim-debugger')
call dein#add('haya14busa/vim-edgemotion')
call dein#add('haya14busa/vim-open-googletranslate')
" call dein#add('haya14busa/incsearch.vim')
" call dein#add('jceb/vim-hier')
call dein#add('kana/vim-altr')
call dein#add('kana/vim-fakeclip')
call dein#add('kana/vim-gf-diff')
call dein#add('kana/vim-gf-user')
call dein#add('kana/vim-metarw', {'lazy': 1})
call dein#add('kana/vim-metarw-git')
call dein#add('kana/vim-narrow', {'lazy': 1})
call dein#add('kana/vim-niceblock')
call dein#add('kana/vim-operator-replace')
call dein#add('kana/vim-operator-user')
" call dein#add('kana/vim-repeat', {'lazy': 1})
call dein#add('kana/vim-smartchr')
call dein#add('kana/vim-smartinput', {'lazy': 1})
call dein#add('kana/vim-smartword')
" call dein#add('kana/vim-submode')
call dein#add('kana/vim-textobj-datetime')
call dein#add('kana/vim-textobj-diff')
call dein#add('kana/vim-textobj-entire')
call dein#add('kana/vim-textobj-fold')
call dein#add('kana/vim-textobj-function')
call dein#add('kana/vim-textobj-indent')
call dein#add('kana/vim-textobj-jabraces')
call dein#add('kana/vim-textobj-line')
call dein#add('kana/vim-textobj-syntax')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-vspec')
call dein#add('previm/previm', {'on_cmd': 'PrevimOpen', 'on_ft': ['markdown', 'textile']})
call dein#add('lambdalisue/vim-findent')
call dein#add('lambdalisue/vim-gita')
call dein#add('lambdalisue/gina.vim')
call dein#add('lambdalisue/vim-gista')
call dein#add('lambdalisue/vim-gista-unite')
call dein#add('lambdalisue/suda.vim')
" call dein#add('vim-scripts/matchit.zip')
call dein#add('andymass/vim-matchup')
call dein#add('mattn/calendar-vim')
call dein#add('mattn/flappyvird-vim')
call dein#add('mattn/gist-vim')
call dein#add('mattn/ideone-vim')
call dein#add('mattn/unite-advent_calendar')
call dein#add('mattn/webapi-vim')
call dein#add('mattn/wwwrenderer-vim')
call dein#add('mfumi/ProjectEuler.vim', {'lazy': 1})
call dein#add('nathanaelkane/vim-indent-guides', {'lazy': 1})
call dein#add('osyo-manga/shabadou.vim')
call dein#add('osyo-manga/unite-quickfix')
call dein#add('osyo-manga/vim-anzu')
call dein#add('osyo-manga/vim-automatic', {'lazy': 1})
" call dein#add('osyo-manga/vim-brightest')
call dein#add('osyo-manga/vim-budou', {'lazy': 1})
call dein#add('osyo-manga/vim-chained')
call dein#add('osyo-manga/vim-over', {'lazy': 1})
call dein#add('osyo-manga/vim-precious', {'lazy': 1})
call dein#add('osyo-manga/vim-reanimate')
call dein#add('osyo-manga/vim-reti')
"call dein#add('osyo-manga/vim-textobj-multiblock')
call dein#add('osyo-manga/vim-textobj-multitextobj')
" call dein#add('osyo-manga/vim-watchdogs')
call dein#add('pocket7878/curses-vim')
call dein#add('pocket7878/presen-vim', {'lazy': 1})
call dein#add('rbtnn/puyo.vim', {'on_cmd': 'Puyo'})
call dein#add('rbtnn/vimconsole.vim')
call dein#add('rhysd/clever-f.vim')
call dein#add('rhysd/committia.vim')
call dein#add('rhysd/github-complete.vim')
call dein#add('rhysd/try-colorscheme.vim', {'on_cmd': 'TryColorscheme'})
call dein#add('rhysd/vim-operator-surround')
call dein#add('rhysd/vim-grammarous')
call dein#add('sgur/unite-qf')
call dein#add('sgur/vim-gf-autoload')
call dein#add('sgur/vim-textobj-parameter')
" call dein#add('sjl/gundo.vim')
call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
call dein#add('soh335/unite-qflist')
call dein#add('vim-scripts/squirrel.vim')
call dein#add('syngan/vim-vimlint')
call dein#add('t9md/vim-choosewin', {'lazy': 1})
call dein#add('t9md/vim-quickhl')
call dein#add('t9md/vim-smalls')
call dein#add('t9md/vim-textmanip', {'lazy': 1})
call dein#add('thinca/vim-ambicmd')
" call dein#add('thinca/vim-auto_source')
call dein#add('thinca/vim-befunge', {'on_cmd': 'Befunge'})
call dein#add('thinca/vim-blink1')
call dein#add('thinca/vim-editvar')
call dein#add('thinca/vim-fontzoom')
call dein#add('thinca/vim-ft-clojure')
call dein#add('thinca/vim-ft-diff_fold')
call dein#add('thinca/vim-ft-help_fold')
call dein#add('thinca/vim-ft-markdown_fold')
call dein#add('thinca/vim-ft-rst_header')
call dein#add('thinca/vim-ft-svn_diff')
call dein#add('thinca/vim-ft-vim_fold')
call dein#add('thinca/vim-github')
call dein#add('thinca/vim-ikaring', {'on_cmd': 'Ikaring'})
call dein#add('thinca/vim-localrc')
call dein#add('thinca/vim-logcat', {'on_cmd': 'LogCat'})
call dein#add('thinca/vim-openbuf')
call dein#add('thinca/vim-operator-sequence')
call dein#add('thinca/vim-painter', {'lazy': 1})
call dein#add('thinca/vim-partedit')
call dein#add('thinca/vim-plz_donate', {'lazy': 1})
call dein#add('thinca/vim-portal')
call dein#add('thinca/vim-poslist')
call dein#add('thinca/vim-prettyprint')
call dein#add('thinca/vim-qfreplace')
call dein#add('thinca/vim-quickmemo')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-ref')
call dein#add('thinca/vim-rtputil')
call dein#add('thinca/vim-scall')
call dein#add('thinca/vim-scouter')
call dein#add('thinca/vim-showtime', {'rev': 'develop'})
call dein#add('thinca/vim-singleton')
call dein#add('thinca/vim-splash', {'lazy': 1})
call dein#add('thinca/vim-submode', {'rev': 'my-master'})
call dein#add('thinca/vim-template')
call dein#add('thinca/vim-textobj-between')
call dein#add('thinca/vim-textobj-comment')
call dein#add('thinca/vim-textobj-function-javascript')
call dein#add('thinca/vim-textobj-function-perl')
call dein#add('thinca/vim-themis')
call dein#add('thinca/vim-threes', {'on_cmd': ['ThreesStart', 'ThreesShowRecord']})
call dein#add('thinca/vim-unite-history')
call dein#add('thinca/vim-visualstar')
call dein#add('thinca/vim-winenv')
call dein#add('thinca/vim-wtrans')
call dein#add('thinca/vim-zenspace')
call dein#add('tpope/vim-repeat')
call dein#add('tsukkee/lingr-vim')
call dein#add('tsukkee/unite-help')
call dein#add('tsukkee/unite-tag')
call dein#add('tyru/capture.vim')
call dein#add('tyru/caw.vim')
call dein#add('tyru/current-func-info.vim', {'lazy': 1})
call dein#add('tyru/emap.vim')
call dein#add('tyru/eskk.vim')
call dein#add('tyru/nextfile.vim')
call dein#add('tyru/open-browser.vim')
call dein#add('tyru/open-browser-github.vim')
call dein#add('tyru/operator-camelize.vim')
call dein#add('tyru/operator-html-escape.vim')
call dein#add('tyru/operator-reverse.vim')
" call dein#add('tyru/qfhist.vim')
call dein#add('tyru/restart.vim')
call dein#add('tyru/savemap.vim')
call dein#add('tyru/simpletap.vim', {'lazy': 1})
call dein#add('tyru/skkdict.vim')
call dein#add('tyru/urilib.vim')
call dein#add('tyru/vice.vim')
call dein#add('ujihisa/neco-look')
call dein#add('ujihisa/neoclojure.vim')
call dein#add('ujihisa/ref-hoogle')
call dein#add('ujihisa/shadow.vim')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('ujihisa/unite-font')
call dein#add('ujihisa/unite-locate')
call dein#add('ujihisa/vimshell-ssh')
call dein#add('vim-scripts/uptime.vim')
call dein#add('vim-jp/autofmt')
call dein#add('vim-jp/vimdoc-ja')
call dein#add('vim-jp/vital.vim', {'merged': 0})
call dein#add('ynkdir/vim-funlib')
call dein#add('ynkdir/vim-vimlparser')
call dein#add('y0za/vim-reading-vimrc')
call dein#add('yomi322/neco-tweetvim')
call dein#add('yomi322/unite-tweetvim')
call dein#add('yomi322/vim-operator-suddendeath')

call dein#add('itchyny/calendar.vim', {'lazy': 1, 'name': 'itchyny-calendar'})

" For OmniSharp
call dein#add('tpope/vim-dispatch', {'lazy': 1})
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('junegunn/vader.vim', {'on_cmd': 'Vader'})
" call dein#add('SirVer/ultisnips')

" Games
call dein#add('katono/rogue.vim', {'on_cmd': ['Rogue', 'RogueScores', 'RogueRestore', 'RogueResume']})

" filetype
call dein#add('othree/html5.vim')
" My ghc-mod is broken...
" call dein#add('eagletmt/ghcmod-vim', {'on_ft': 'haskell'})
call dein#add('kana/vim-filetype-haskell')
call dein#add('ujihisa/neco-ghc', {'on_ft': 'haskell'})
call dein#add('derekwyatt/vim-scala', {'on_ft': 'scala'})
call dein#add('vim-scripts/groovyindent')
call dein#add('OmniSharp/omnisharp-vim', {
\   'on_ft': ['cs', 'csharp'],
\   'build':
\     has('win32') ? 'omnisharp-roslyn/build.cmd'
\                  : 'bash omnisharp-roslyn/build.sh || true',
\ })
call dein#add('superbrothers/vim-vimperator')
call dein#add('kchmck/vim-coffee-script')
call dein#add('elzr/vim-json')
call dein#add('leafo/moonscript-vim')
call dein#add('pangloss/vim-javascript')
call dein#add('jsx/jsx.vim', {'on_ft': 'jsx'})
call dein#add('zah/nimrod.vim')
call dein#add('vim-scripts/jam.vim')
call dein#add('Rykka/riv.vim', {'on_ft': 'rst'})
call dein#add('timcharper/textile.vim')
call dein#add('rbtnn/powershell.vim')
call dein#add('kongo2002/fsharp-vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/tsuquyomi')
" call dein#add('honza/dockerfile.vim', {'on_ft': 'dockerfile'})
call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
call dein#add('racer-rust/vim-racer', {'on_ft': 'rust'})
call dein#add('elixir-lang/vim-elixir')
call dein#add('Matt-Deacalion/vim-systemd-syntax')
" call dein#add('fatih/vim-go')
" call dein#add('vim-jp/vim-go-extra', {'on_ft': 'go'})
call dein#add('tmux-plugins/vim-tmux')
call dein#add('cespare/vim-toml')
call dein#add('plasticboy/vim-markdown')
call dein#add('udalov/kotlin-vim')
call dein#add('rhysd/vim-gfm-syntax')
call dein#add('jparise/vim-graphql')
call dein#add('slim-template/vim-slim')
call dein#add('pocke/iro.vim', {
\   'build': 'bundle install',
\   'if': has('ruby'),
\   'rev': 'iro-with-vim-syntax',
\ })

" colorscheme
call dein#add('romainl/Apprentice')
call dein#add('rhysd/vim-color-splatoon')
call dein#add('morhetz/gruvbox')

" libray
call dein#add('haya14busa/vital-vimlcompiler')
call dein#add('haya14busa/vital-power-assert')

" Trial use
call dein#add('thinca/ale', {'rev': 'do-not-change-rtp'})
call dein#add('machakann/vim-vimhelplint')

let s:local_dein = expand('~/.config/vim/local.dein.vim')
if filereadable(s:local_dein)
  execute 'source' fnameescape(s:local_dein)
endif

call dein#end()

call dein#save_state()

if dein#check_install()
  call dein#install()
endif
