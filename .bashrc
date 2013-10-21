# Workaround for scp. Scp defines TERM to which makes tput complain.
if [[ $TERM == dumb ]]; then
    export TERM=xterm
else
    export TERM=xterm-16color
fi

# Set prompt
case $TERM in
    xterm*|screen*|gnome*|eterm*)
        PS1="\[\033]0;\u@\h: \w\007\]\\[$(tput setaf 9)\]\u@\h \[$(tput setaf 4)\]\w\n\[$(tput sgr0)\][\A - \!]$ "
        ;;
    *)
        PS1="[\u@\h] \w $ "
        ;;
esac

export EDITOR=emacs
export SVN_EDITOR=emacs

if [[ -r ~/.local.bashrc ]]; then
    source ~/.local.bashrc
fi

#time format for history command
export HISTTIMEFORMAT="[%d/%m/%y - %T] "

#aliases
alias sps='ps --forest -o pid,pgid,args'
alias ssps='ps --forest --user=$USER -o pid,pgid,args'
alias ls='ls --color=auto'
alias h='history'
alias ec="emacsclient -n"
alias hgrep='history | grep'

#bash configuration
shopt -s histappend
set -o ignoreeof #disable ctrl+D on login shell

PATH=$HOME/bin:$PATH

if [[ -r ~/.dircolors ]]; then
    eval $(dircolors ~/.dircolors)
fi

# Cleanup PATH and LD_PATH duplicates
if [[ -x /bin/awk ]]; then
    export PATH=$(echo "$PATH" | /bin/awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}')
    export LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | /bin/awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}')
fi

