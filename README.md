# Mac OS X setup

This is a list of reproducable steps to get Mac OS X up and running with necessary development tools. Personally I don't use virtualenvwrapper, but if you do, uncomment the corresponding lines in .bashrc.


## Step 1. Dotfiles
### Using Git and the bootstrap script
You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.

    git clone https://github.com/kevinrenskers/dotfiles.git && cd dotfiles && ./bootstrap.sh

To update, `cd` into your local `dotfiles` repository and then:

    ./bootstrap.sh

Alternatively, to update while avoiding the confirmation prompt:

    ./bootstrap.sh -f

### Git-free install
To install these dotfiles without Git:

    cd; curl -#L https://github.com/kevinrenskers/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}

To update later on, just run that command again.

### Add custom commands without creating a new fork

If `~/.bash_extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.bash_extra` looks something like this:

    # PATH additions
    export ARCHFLAGS='-arch x86_64'
    export PATH=/usr/local/bin:~/bin:$PATH
    export NODE_PATH=/usr/local/lib/node_modules

    # Git credentials
    # Not in the repository, to prevent people from accidentally committing under my name
    GIT_AUTHOR_NAME="Kevin Renskers"
    GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
    git config --global user.name "$GIT_AUTHOR_NAME"
    GIT_AUTHOR_EMAIL="info@mixedcase.nl"
    GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
    git config --global user.email "$GIT_AUTHOR_EMAIL"


## Step 2. Setup Mac OS X
    # 1. install Xcode from the App Store
    # 2. install SourceTree from the App Store
    # 2. install HomeBrew:
    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
    # 3. Install bash completion:
    $ brew install bash-completion
    # 4. install http://coderwall.com/p/dlithw

When setting up a new Mac, you may want to install some sensible Mac OS X defaults:

    $ . .osx


## Step 3. Python and Mercurial
    $ brew install giflib
    $ brew install jpeg
    $ sudo easy_install readline
    $ sudo easy_install pip
    $ sudo pip install virtualenv
    $ sudo pip install PIL
    $ sudo pip install mercurial
    $ sudo pip install ipython


## Step 4. PostgreSQL
    $ brew install postgresql
    $ initdb /usr/local/var/postgres
    $ mkdir -p ~/Library/LaunchAgents
    $ cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist
    $ sudo pip install psycopg2


## Step 5. MySQL
    $ brew install mysql
    $ unset TMPDIR
    $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
    $ cp /usr/local/Cellar/mysql/5.5.14/com.mysql.mysqld.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist
    $ sudo pip install mysql-python


## Step 6. Node.js and NPM (Node Package Manager)
    $ PREFIX=$(brew --prefix)
    $ sudo mkdir -p $PREFIX/{share/man,bin,lib/node,include/node}
    $ sudo chown -R $USER $PREFIX/{share/man,bin,lib/node,include/node}
    $ brew install node
    $ curl http://npmjs.org/install.sh | sh


## Step 7. Optional: coffeescript and Less (requires step 6)
    $ npm install -g coffee-script
    $ npm install -g less


## Step 8. Ruby and rvm (Ruby Version Manager)
    $ bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
    $ source .bashrc
    $ rvm install 1.9.2
    $ rvm --default use 1.9.2


## Step 9. Optional: ruby packages (requires step 8)
    $ gem install rails
    $ gem install sass
    $ gem install sinatra


## Thanks to...
* Mathias Bynens for sharing [his dotfiles](https://github.com/mathiasbynens/dotfiles), bootstrap script and installation instructions.
