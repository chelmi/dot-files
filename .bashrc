# Workaround for scp. Scp defines TERM to which makes tput complain.
if [[ $TERM == dumb ]]; then
    export TERM=xterm
fi

case $TERM in
    xterm*|screen*)
	PS1="\[\033]0;\u@\h: \w\007\]\[$(tput bold)\]\\[$(tput setaf 6)\]\u@\h \[$(tput setaf 4)\]\w\n\[$(tput sgr0)\][\A - \!]$ "
        ;;
    *)
        PS1="bash\\$ "
        ;;
esac

export PATH=$HOME/bin:$PATH
export LANG=en_US.UTF8
export EDITOR=vi
export SVN_EDITOR=vi

#UNV specific init
if [[ $(hostname) = grid-unv* ]]; then
    export TMP_DIR=/work
    export GRADLE_USER_HOME=$TMP_DIR/.michel_metzger.gradle
fi

if [[ -r ~/.local.bashrc ]]; then
    source ~/.local.bashrc
fi

#time format for history command
export HISTTIMEFORMAT="[%d/%m/%y - %T] "

#aliases
alias sps='ps --forest --user=michel_metzger -o pid,pgid,args'
alias ls='ls --color=auto'
alias h='history'

function gridbash {
    qrsh -now n -pty y -l himem -l h_vmem=$1,mem_free=$1 -j y -V -cwd 'bash'
}

alias gridbash24="gridbash 24G"
alias gridbash32="gridbash 32G"
alias gridbash48="gridbash 48G"
alias ec="emacsclient -n"
alias hgrep='history | grep'

#bash configuration
shopt -s histappend
set -o ignoreeof #disable ctrl+D on login shell