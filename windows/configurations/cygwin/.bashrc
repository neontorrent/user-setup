#/bin/bash
#This file is for cygwin only

alias vi=vim
alias la='ls -al'
alias clear='printf "\033c"'
alias psw='ps -eflW'
alias killw='taskkill /F /pid '
alias killall='TaskKill /F /IM '

export ANT_HOME=~/bin/apache-ant-1.9.2
export JAVA_HOME=~/bin/java/jdk1.6.0_25
export M2_HOME=~/bin/apache-maven-2.2.1
export AXIS2_HOME=~/bin/axis2-1.7.0
export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$M2_HOME/bin:$AXIS2_HOME/bin:~/bin:$PATH

export ANT_OPTS=" -Xms512m -Xmx4028m"

export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \@ > \[\e[33m\]\w\[\e[0m\]\n\$"

function tmux_insert_window {
        for ((i=$1;i<$2;i++));do
                tmux swap-window -s :$i -t :$((i+1))
        done
}


function set_java {
    if [ $1 == '1.6' -o $1 == '6' ]; then
        export JAVA_HOME=~/bin/java/jdk1.6.0_25
        export PATH=$JAVA_HOME/bin:$PATH
    elif [ $1 == '1.8' -o $1 == '8' ]; then
        export JAVA_HOME=~/bin/java/jdk1.8.0_72
        export PATH=$JAVA_HOME/bin:$PATH
    fi
}

function ssh_tb {
    ssh -F/dev/null bruce@texasbruce.com
}

[ $TERM != "cygwin" ] && [ -z $TMUX ] && tmux
