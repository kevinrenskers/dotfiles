# Install the dotfiles

## Using Git and the bootstrap script
You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.

    git clone https://github.com/kevinrenskers/dotfiles.git && cd dotfiles && ./bootstrap.sh

To update, `cd` into your local `dotfiles` repository and then:

    ./bootstrap.sh

Alternatively, to update while avoiding the confirmation prompt:

    ./bootstrap.sh -f

## Git-free install
To install these dotfiles without Git:

    cd; curl -#L https://github.com/kevinrenskers/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={INSTALL.md,README.md,bootstrap.sh}

To update later on, just run that command again.

## Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

    export ARCHFLAGS='-arch x86_64'

    # Make nano the default editor (don't hate me...)
    export EDITOR=nano
    export GIT_EDITOR=nano

    # Git credentials
    git config --global user.name "Kevin Renskers"
    git config --global user.email "info@mixedcase.nl"

    # Configure Agnoster theme
    DEFAULT_USER='kevin'
    
    # Show the ~/Library folder
    chflags nohidden ~/Library
