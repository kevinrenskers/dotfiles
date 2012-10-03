# Mac OS X setup

This is a list of reproducible steps to get Mac OS X up and running with necessary development tools.


## Step 1. Setup Mac OS X
    # 1. install Xcode from the App Store
    # 2. open Xcode's preferences and install the command line tools package (this will also install Git)
    # 3. install SourceTree from the App Store
    # 4. install HomeBrew:
    $ /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
    # 5. Install bash completion:
    $ brew install bash-completion
    # 6. install http://coderwall.com/p/dlithw
    # 7. install http://www.starryhope.com/keyfixer/


## Step 2. Dotfiles and default settings
See the file INSTALL.md for dotfile installation instructions.


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
    $ curl -L https://get.rvm.io | bash -s stable --ruby
    $ rvm install 1.9.2
    $ rvm --default use 1.9.2


## Step 9. Optional: ruby packages (requires step 8)
    $ gem install rails
    $ gem install sass
    $ gem install sinatra
    $ gem install cocoapods


## Thanks to...
* Mathias Bynens for sharing [his dotfiles](https://github.com/mathiasbynens/dotfiles), bootstrap script and installation instructions.
