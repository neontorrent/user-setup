#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#"
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

alias vi=vim
#alias xargs="xargs -I '{}'"

if [ -n "$MSYSTEM" ]; then
    export ROOT_DIR=/d
    export MINGW_ROOT=/
elif [ -n "$WSLENV" ]; then
    export ROOT_DIR=/mnt/d
    export MINGW_ROOT=${ROOT_DIR}/Applications/msys64
fi

export USEROPT=${ROOT_DIR}/opt
export SCALA_HOME=${USEROPT}/scala/scala-2.13.2
export SBT_HOME=${USEROPT}/sbt/sbt-1.3.10
export M2_HOME=${USEROPT}/maven/current
export FFMPEG_BIN=${USEROPT}/ffmpeg/bin
export DOCKER_ROOT=${ROOT_DIR}/Applications/Docker\ Toolbox
export FLUTTER_ROOT=${USEROPT}/flutter
export DART_HOME=${USEROPT}/dart/dart-sdk-windows-x64-2.9.0-9.0.dev

export PKG_CONFIG_PATH=$MINGW_ROOT/mingw64/lib/pkgconfig

if [ -n "$MSYSTEM" ]; then
	export JAVA_HOME=${USEROPT}/java/graalvm-ce-java11-20.2.0-dev

	alias jshell="winpty jshell"
	#alias scala="winpty scala.bat"
	alias flutter=flutter.bat

	export NODE_REPL_HISTORY=D:/.node_repl_history
	#export GOROOT=${USEROPT}/go/go-1.11.4-windows-amd64

ln(){
	local param
	local target
	local link
	if [ $(echo "$1" | grep -e "^-.*s.*$") ]; then
		target="$2"
		link="$3"
		if [ -f "$2" ]; then
			param=
		elif [ -d "$2" ]; then
			param='//D'
		else
			echo "File $2 does not exist"
			exit 1
		fi
	else
		param='//H'
		target="$1"
		link="$2"
	fi
	echo $param $link $target
	cmd //C mklink $param $link $target
}

elif [ -n "$WSLENV" ]; then
    export DISPLAY=:0
	export LIBGL_ALWAYS_INDIRECT=1
	export NODE_REPL_HISTORY=${HOME}/.node_repl_history

	export USERLOCAL=${HOME}/.local
	export JAVA_HOME=${HOME}/.jdks/current
fi

export PATH=${SCALA_HOME}/bin:${SBT_HOME}/bin:$M2_HOME/bin:${HOME}/bin:${JAVA_HOME}/bin:${DART_HOME}/bin:${FLUTTER_ROOT}/bin:${DOCKER_ROOT}:$FFMPEG_BIN:$MINGW_ROOT/mingw64/bin:$MINGW_ROOT/mingw32/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/bruce/.sdkman"
#[[ -s "/home/bruce/.sdkman/bin/sdkman-init.sh" ]] && source "/home/bruce/.sdkman/bin/sdkman-init.sh"
