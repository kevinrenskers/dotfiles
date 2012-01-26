Mac OS X setup

This is a list of reproducable steps to get Mac OS X up and running with necessary development tools.
Personally I don't use virtualenvwrapper, but if you do, uncomment the lines in .bashrc.


Step 1. Dependencies
--------------------
    # install DiffMerge from http://www.sourcegear.com/diffmerge/downloads.php
    # install Xcode from the App Store
    # install HomeBrew and bash-completion:
    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
    $ brew install bash-completion


Step 2. Python and Mercurial
----------------------------
    $ brew install giflib
    $ brew install jpeg
    $ sudo easy_install readline
    $ sudo easy_install pip
    $ sudo pip install virtualenv
    $ sudo pip install PIL
    $ sudo pip install mercurial
    $ sudo pip install ipython


Step 3. Dotfiles - Please note that you probably want to COPY the files and EDIT them, instead of symlinking
------------------------------------------------------------------------------------------------------------
    $ cd ~
    $ git clone git://github.com/kevinrenskers/dotfiles.git
    $ ln -s dotfiles/.bash_profile
    $ ln -s dotfiles/.bashrc
    $ ln -s dotfiles/.hgignore
    $ ln -s dotfiles/.hgrc
    $ ln -s dotfiles/.gitignore
    $ ln -s dotfiles/.gitconfig
    $ mkdir -p bin
    $ cd bin
    $ ln -s ~/dotfiles/diffmerge.sh
    $ ln -s ~/dotfiles/git_completion.sh
    $ cd ..
    $ source .bashrc


Step 4. PostgreSQL
------------------
    $ brew install postgresql
    $ initdb /usr/local/var/postgres
    $ mkdir -p ~/Library/LaunchAgents
    $ cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist
    $ sudo pip install psycopg2


Step 5. MySQL
-------------
    $ brew install mysql
    $ unset TMPDIR
    $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
    $ cp /usr/local/Cellar/mysql/5.5.14/com.mysql.mysqld.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist
    $ sudo pip install mysql-python


Step 6. Node.js and NPM (Node Package Manager)
----------------------------------------------
    $ PREFIX=$(brew --prefix)
    $ sudo mkdir -p $PREFIX/{share/man,bin,lib/node,include/node}
    $ sudo chown -R $USER $PREFIX/{share/man,bin,lib/node,include/node}
    $ brew install node
    $ curl http://npmjs.org/install.sh | sh


Step 7. Coffeescript and Less (requires step 6)
-----------------------------------------------
    $ npm install -g coffee-script
    $ npm install -g less


Step 8. Ruby and rvm (Ruby Version Manager)
-------------------------------------------
    $ bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
    $ source .bashrc
    $ rvm install 1.9.2
    $ rvm --default use 1.9.2


Step 9. Optional Ruby packages (requires step 8)
------------------------------------------------
    $ gem install rails
    $ gem install sass
    $ gem install sinatra
