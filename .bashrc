# aliases
alias ..="cd .."
alias ...="cd ..; cd .."
alias cd..="cd .."
alias l="ls -lahp"
alias rmpyc='find . -name "*.pyc" -print0|xargs -0 rm'
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# exports
export ARCHFLAGS='-arch x86_64'
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export PATH=/usr/local/bin:$HOME/bin:$PATH
export NODE_PATH=/usr/local/lib/node_modules

# enable the Library folder
chflags nohidden ~/Library

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
# enable bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi

source $HOME/bin/git_completion.sh

# load RVM (ruby version manager)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# optional: virtualenvwrapper (sudo pip install virtualenvwrapper)
#export WORKON_HOME=$HOME/Virtualenvs
#export PROJECT_HOME=$HOME/Workspace
#source /usr/local/bin/virtualenvwrapper.sh

hg_in_repo() {
    [[ `hg branch 2> /dev/null` ]] && echo "on "
}
 
hg_branch() {
    hg branch 2> /dev/null | awk "{print $1}"
}

__has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing
    # up a separate process
    test -d "$1" && return 0;
 
    current="."
    while [ ! "$current" -ef "$current/.." ]; do 
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done
 
    return 1;
}
 
__vcs_name() {
    if [ -d .svn ]; then 
        echo "[svn] "; 
    elif [ -d RCS ]; 	then 
        echo "[RCS] ";  
    elif __has_parent_dir ".git"; then
        echo "$(__git_ps1 '[git %s] ')";
    elif __has_parent_dir ".hg"; then
        echo "[hg $(hg branch)] "
    fi
}

# set up named colors
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
BROWN="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
GRAY="\[\033[1;30m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[1;33m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[0;37m\]"
UNDERLINE="\[\033[4m\]"
NO_COLOUR="\[\033[0m\]"
 
# outputs a warning if the last command failed
function return_value_indicator {
    if [ $? != 0 ]; then
        echo "1"
    fi
}
 
# set default commands
export EDITOR=pico
export GIT_EDITOR=pico
export PAGER=less
 
# set some options to colorize things
export TERM=xterm-color
export CLICOLOR=1
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

# bash history settings
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll:lla"
shopt -s histappend # append to the history file, don't overwrite it

# bash completion settings (actually, these are readline settings)
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous on" # show list automatically, without double tab

# set the prompt
function prompt {
    export PS1="\[\033[G\]$BLUE\$(__vcs_name)$NO_COLOUR\u@\h: $BLUE\w$NO_COLOUR $ "
}

prompt
