alias ll "ls -al"

echo "[date]"
date
echo "[uptime]"
uptime

#python関連の処理
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
