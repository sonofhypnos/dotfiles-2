if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

shopt -s dotglob
shopt -s nocaseglob
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend

HISTSIZE=25000
HISTFILESIZE=25000

asura_logdir=/data/log/sns.asura
asura_reqlog=/data/log/sns.asura/asura.log

function _asura_logfiles () {
    find $asura_logdir -name '*.log' | perl -ne 'print if /\/[^\.]+\.log/'
}

function rid_trace () {
    grep -h $1 `_asura_logfiles` | sort -g
}

function highcost () {
    local awk_expr='int($NF) >= '"${2:-500}"
    [ -z $1 ] && return 1
    grep $1 $asura_reqlog | awk "$awk_expr"
}
