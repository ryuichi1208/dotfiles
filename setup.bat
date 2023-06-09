@echo off

goto :main

:link
del %1 2>nul
mklink %1 %2
goto :EOF

:dlink
rmdir %1 2>nul
mklink /d %1 %2
goto :EOF

:main
setlocal enabledelayedexpansion

set HOME=%HOMEDRIVE%%HOMEPATH%
set CONFIG=%~dp0
set DOTFILES=%CONFIG%dotfiles

for /D %%D in (%DOTFILES%\dot.config\*) do (
  set CONFIG_DIR=%LOCALAPPDATA%\%%~nD
  if not exist !CONFIG_DIR! (
    mkdir !CONFIG_DIR!
    pushd !CONFIG_DIR!
    call :dlink Config %%D
    popd
  )
)

pushd %HOME%

call :dlink .config %DOTFILES%\dot.config

call :link _nya %CONFIG%\windows\ckw\_nya

call :link .hgrc %DOTFILES%\dot.hgrc
call :link .hgignore %DOTFILES%\dot.hgignore
call :link .inputrc %DOTFILES%\dot.inputrc
call :link .irbrc %DOTFILES%\dot.irbrc
call :dlink .vim %DOTFILES%\dot.vim
call :dlink vimfiles %DOTFILES%\dot.vim
call :link .zshrc %DOTFILES%\dot.zshrc
call :dlink .zsh %DOTFILES%\dot.zsh

popd

endlocal

pause
