set EDITOR pico 
set GIT_EDITOR pico 
set -U fish_prompt_pwd_dir_length 0

set -x -g COCOAPODS_DISABLE_STATS true
set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/python@3.10/libexec/bin
fish_add_path /Users/kevin/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/kevin/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
