USERBASE=~/.local
export PERL5LIB="$USERBASE/lib/perl5:$PERL5LIB"
export PERL_MB_OPT="--install_base $USERBASE"
export PERL_MM_OPT="INSTALL_BASE=$USERBASE"
unset USERBASE
