#!/bin/bash

alias vi=vim
alias ls='ls -G'

export PS1='[\u@\h \w] `date`\n'
export EDITOR="/usr/bin/vim"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home"


export PERL_MB_OPT="--install_base \"/Users/bruce/.perl5\"";
export PERL_MM_OPT="INSTALL_BASE=/Users/bruce/.perl5";
export PERL5LIB="/Users/bruce/.perl5/lib/perl5":"/usr/local/lib/perl5/site_perl":$PERL5LIB


#export HOMEBREW_GITHUB_API_TOKEN="a0fe049482fa19b8e35e052c5d6e58cbf14d1c63"
export HOMEBREW_GITHUB_API_TOKEN="3e0f9616be89c71ff11917c55f8040dae854f2ed"
export HOMEBREW_NO_AUTO_UPDATE=1

export PATH="~/bin":"/Users/bruce/.node_modules/bin":"$PERL5LIB/../../bin":"/Users/bruce/bin/scala-2.11.7/bin:/usr/local/sbin/:$PATH"

#Disable sdkman on start up
function sdk {
    echo "Initializing sdkman. Please run the command again later."
    unset -f sdk

    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="/Users/bruce/.sdkman"
    [[ -s "/Users/bruce/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bruce/.sdkman/bin/sdkman-init.sh"
}
