parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' ('$branch') '
  fi
}

function contains {
    str="$1"
    substr="$2"
    [ "$str" != "${str/$substr/}" ] && echo "$substr"
}

function is_zsh {
    shellprocname=$(ps -T -o command= $$)
    contains "$shellprocname" "zsh"
}

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

setopt prompt_subst

export PROMPT="[%n@%m %d%B%F{cyan}\$(git_branch_name)%f%b]"$'\n'"$ "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
