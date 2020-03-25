" -----------------------------------------------------------------
" INDENT
" -----------------------------------------------------------------
augroup fileTypeIndent
  autocmd!
  autocmd FileType bash       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType go         setlocal sw=8 sts=8 ts=8 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType markdown   setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType rust       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et

  autocmd FileType perl,cgi   compiler perl
  autocmd FileType python     setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType ruby       compiler ruby
  autocmd FileType go         setlocal noexpandtab
augroup END

" -----------------------------------------------------------------
" TypeScript
" -----------------------------------------------------------------
augroup typescriptfiletype
  au BufNewFile,BufRead *.ts setlocal filetype=typescript
  au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
augroup END

" -----------------------------------------------------------------
" LESS
" -----------------------------------------------------------------
augroup lessfiletype
  au BufNewFile,BufRead *.less setlocal filetype=scss
augroup END

" -----------------------------------------------------------------
" Blade
" -----------------------------------------------------------------
augroup bladefiletype
  autocmd BufNewFile,BufRead *.blade.php set filetype=blade
augroup END

" -----------------------------------------------------------------
" Configuration
" -----------------------------------------------------------------
augroup conf
  autocmd BufNewFile,BufRead *.conf set filetype=conf
augroup END

" -----------------------------------------------------------------
" Solidity
" -----------------------------------------------------------------
augroup solidity
  autocmd BufNewFile,BufRead *.sol set filetype=solidity
augroup END

" -----------------------------------------------------------------
" Terraform
" -----------------------------------------------------------------
augroup terraform
  autocmd BufNewFile,BufRead *.tf set filetype=terraform
  autocmd BufNewFile,BufRead *.tfvars set filetype=terraform
augroup END
