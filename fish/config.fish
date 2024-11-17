set EDITOR pico 
set GIT_EDITOR pico 
set -U fish_prompt_pwd_dir_length 0

set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH

# Aliasses
alias pico "nano" # nano is just better than pico, it supports syntax highlighting
alias cat "bat" # bat is a much nicer cat, https://github.com/sharkdp/bat
alias l "ls -Glaph" # list contents of directory, including hidden files in directory using long format, colorized, appended slash to folders