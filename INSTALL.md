## Install the dotfiles
You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.

    git clone https://github.com/kevinrenskers/dotfiles.git && cd dotfiles && ./bootstrap.sh

To update, `cd` into your local `dotfiles` repository and then:

    ./bootstrap.sh

Alternatively, to update while avoiding the confirmation prompt:

    ./bootstrap.sh -f

## Add custom commands without creating a new fork
If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

    export ARCHFLAGS='-arch x86_64'

    # Make nano the default editor (don't hate me...)
    export EDITOR=nano
    export GIT_EDITOR=nano

    # Git credentials
    git config --global user.name "Kevin Renskers"
    git config --global user.email "kevin@mixedcase.nl"

    # Show the ~/Library folder
    chflags nohidden ~/Library

Please note that `~/.extra` is loaded by both Bash and ZSH. If you have ZSH specific things, put them in `~/.zshextra`. Mine looks like this:

    plugins=(git brew gem npm pip rvm django virtualenv pod virtualenvwrapper bower)
