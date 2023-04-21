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

setopt prompt_subst

export PROMPT="[%n@%m %d%B%F{cyan}\$(git_branch_name)%f%b]"$'\n'"$ "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
