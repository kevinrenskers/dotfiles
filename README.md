# Mac OS X setup

This is a list of reproducible steps to get Mac OS X up and running with necessary development tools. Tested on Mountain Lion.


## Step 1: prepare Mac OS X

1. Install Xcode from the App Store
2. Open Xcode's preferences and install the command line tools package (this will also install Git)
3. Install http://coderwall.com/p/dlithw *(optional)*
4. Install http://www.starryhope.com/keyfixer/ *(optional)*
5. On a fresh Mac you might want to run `$ . .osx` to setup some sensible defaults *(optional)*


## Step 2: install Homebrew and the bash-completion package

    $ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    $ brew install bash-completion


## Step 3: install the dotfiles

The dotfiles setup everything from your bash prompt and handy git aliases to new shortcut commands like `localip` and `rmds`.

    $ git clone https://github.com/kevinrenskers/dotfiles.git && cd dotfiles && ./bootstrap.sh
    
Restart your shell after it's done.
    
Read the INSTALL.md file for more detailed instructions and tips.


## Step 4: anything else you need *(optional)*

### Python

    $ brew install giflib jpeg
    $ sudo easy_install readline
    $ sudo easy_install pip
    $ sudo pip install virtualenv
    $ sudo pip install PIL
    
    
### Ruby and RVM (Ruby Version Manager)

    $ curl -L https://get.rvm.io | bash -s stable --ruby
    
Ignore the instructions to insert the rvm script into your bash profile - if you installed my dotfiles, that's already included.
    
Restart your shell after it's done and test with `ruby --version`, it should have installed version 2.x. If you want to stay on Ruby 1.9.3, run these commands after restarting your shell:

    $ rvm install 1.9.3
    $ rvm --default use 1.9.3

Once RVM is installed you can install your favorite packages:

    $ gem install cocoapods
    $ gem install rails


### PostgreSQL

    $ brew install postgresql
    $ initdb /usr/local/var/postgres
    $ mkdir -p ~/Library/LaunchAgents
    $ cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist
    $ sudo pip install psycopg2


### MySQL

    $ brew install mysql
    $ unset TMPDIR
    $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
    $ ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
    $ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
    $ /usr/local/opt/mysql/bin/mysqladmin -u root password 'new-password'
    
For use with PHP, edit `/etc/php.ini` (possible named `/etc/php.ini.default`) and replace `mysql.default_socket = /var/mysql/mysql.sock` with `default_socket = /tmp/mysql.sock`


### Node.js and NPM (Node Package Manager)

    $ PREFIX=$(brew --prefix)
    $ sudo mkdir -p $PREFIX/{share/man,bin,lib/node,include/node}
    $ sudo chown -R $USER $PREFIX/{share/man,bin,lib/node,include/node}
    $ brew install node
    $ curl https://npmjs.org/install.sh | sh

Once NPM is installed you can install your favorite packages:

    $ npm install -g coffee-script
    $ npm install -g less


## Thanks to...
* Mathias Bynens for sharing [his dotfiles](https://github.com/mathiasbynens/dotfiles), bootstrap script and installation instructions.
