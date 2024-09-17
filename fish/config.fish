set EDITOR pico 
set GIT_EDITOR pico 
set -U fish_prompt_pwd_dir_length 0

set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
pyenv init - | source

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
