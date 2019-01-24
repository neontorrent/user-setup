#/bin/bash
#This file is for cygwin only

alias vi=vim
alias la='ls -al'
alias clear='printf "\033c"'
alias psw='ps -eflW'
alias killw='taskkill /F /pid '
alias killall='TaskKill /F /IM '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export M2_HOME=~/bin/apache-maven-2.2.1
export AXIS2_HOME=~/bin/axis2-1.7.0
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


export GIT_TERMINAL_PROMPT=1
export SCALA_HOME=${HOME}/opt/scala/scala-2.12.6
export GOPATH=${HOME}/.go
export PKG_CONFIG_PATH=/mingw64/lib/pkgconfig

if [ -n "$MSYSTEM" ]; then

        alias jshell="winpty jshell"

        export DOCKER_ROOT=/d/Applications/Docker\ Toolbox
        export NODE_REPL_HISTORY=E:/.node_repl_history

        export USEROPT=${HOME}/.windows

        export JAVA_HOME=${USEROPT}/java/jdk-11.0.1
        export GOROOT=${USEROPT}/go/go-1.11.4-windows-amd64

        export PATH=${USEROPT}/Git/cmd:${USEROPT}/ffmpeg/bin:${USEROPT}/nim/nim-0.19.0/bin:${DOCKER_ROOT}/:${JAVA_HOME}/bin:${SCALA_HOME}/bin:${GOROOT}/bin:${HOME}/bin:/mingw64/bin/:$PATH

else

        if [ -z "$(uname -a | grep Microsoft)" ]; then
                export JAVA_HOME=${USEROPT}/java/jdk-8u181-linux-x64
        fi

        export USERLOCAL=${HOME}/.local
        export USEROPT=${USERLOCAL}/opt

        export GOROOT=${USEROPT}/go/go-1.10.3-linux-amd64
        export PATH=${JAVA_HOME}/bin:${SCALA_HOME}/bin:${GOROOT}/bin:~/bin:$PATH
        export NODE_REPL_HISTORY=${HOME}/.node_repl_history

fi



[ $TERM != "cygwin" ] && [ -z $TMUX ] && tmux
