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

    cd; curl -#L https://github.com/kevinrenskers/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}

To update later on, just run that command again.

## Add custom commands without creating a new fork

If `~/.bash_extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.bash_extra` looks something like this:

    # PATH additions
    export ARCHFLAGS='-arch x86_64'
    export PATH=/usr/local/sbin:/usr/local/bin:~/bin:$PATH
    export NODE_PATH=/usr/local/lib/node_modules
    
    # Make nano the default editor (don't hate me...)
    export EDITOR=nano
    export GIT_EDITOR=nano
    
    # Git credentials
    # Not in the repository, to prevent people from accidentally committing under my name
    GIT_AUTHOR_NAME="Kevin Renskers"
    GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
    git config --global user.name "$GIT_AUTHOR_NAME"
    GIT_AUTHOR_EMAIL="info@mixedcase.nl"
    GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
    git config --global user.email "$GIT_AUTHOR_EMAIL"

## Install defaults
When setting up a new Mac, you may want to install some sensible Mac OS X defaults:

    $ . .osx
