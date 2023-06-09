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
if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

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

"----------------------------------------------------------
" Other
"----------------------------------------------------------
runtime! ./options.vim
runtime! ./keymap.vim
runtime! ./functions.vim
runtime! ./indent.vim

let g:python_host_prog="/usr/local/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"
