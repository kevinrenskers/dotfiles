# Mac OS X setup

This is a list of reproducible steps to get a clean Mac up and running with nice dotfiles for Fish, plus a whole bunch of apps and development tools.

![Fish theme](screenshot.png)


## Step 1: prepare Mac OS X

1. Install Xcode from the App Store
2. Install the command line tools package with `xcode-select --install`
3. Install http://www.starryhope.com/keyfixer/ *(optional)*

Set your git credentials:

    git config --global user.name "Kevin Renskers"
    git config --global user.email "kevin@loopwerk.io"

## Step 2: install Homebrew

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Very handy first install:

    $ brew cask install qlstephen    

To update all installed packages:

    $ brew update  
    $ brew upgrade
    $ brew cleanup


## Step 3: install Fish shell

    brew install fish


## Step 4: dotfiles

Install the dotfiles

    $ git clone https://github.com/kevinrenskers/dotfiles.git && cd dotfiles && ./bootstrap.sh

And set your default shell to Fish:

    $ chsh -s /usr/local/bin/fish

**Restart your shell after it's done.** 

You can now run `fish_config` to change the terminal colors, abbreviations, etc.

On a fresh Mac you might want to run `. .osx` to setup some sensible defaults.


## Step 5: anything else you need

### Python
I'm using [Homebrew's Python](https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python) because it's newer and comes with pip and setuptools.

    $ brew install python giflib jpeg
    $ pip install wheel virtualenvwrapper PIL

Upgrade pip itself:

    $ pip install --upgrade pip

To upgrade setuptools, which is used by pip:

    $ pip install --upgrade setuptools


### Ruby, RVM (Ruby Version Manager) and RubyGems

    $ curl -L https://get.rvm.io | bash -s stable --ruby    

Ignore the instructions to insert the rvm script into your bash profile - if you installed my dotfiles, that's already included.
    
**Restart your shell after it's done** and test with `ruby --version`, it should have installed version 2.x. If you want to stay on Ruby 1.9.3, run these commands after restarting your shell:

    $ rvm install 1.9.3
    $ rvm --default use 1.9.3

Once RVM is installed you can install your favorite packages:

    $ gem install cocoapods
    $ gem install rails

To update RVM itself:

    $ rvm get stable

To update RubyGems itself:

    $ gem update --system


### PostgreSQL

    $ brew install postgresql
    $ initdb /usr/local/var/postgres
    $ cp /usr/local/Cellar/postgresql/9.2.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/
    $ launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist

To use with Python:

    $ export CFLAGS=-Qunused-arguments
    $ export CPPFLAGS=-Qunused-arguments
    $ sudo pip install psycopg2

Or simply download Postgress.app from http://postgresapp.com.


### MySQL

    $ brew install mysql
    $ brew services start mysql
    $ mysql_secure_installation

To use with Python:

    $ sudo pip install mysql-python

Manually Starting and stopping the server:

    $ mysql.server start
    $ mysql.server start


### Node.js and NPM (Node Package Manager)

    $ brew install node

Once this is installed you can install your favorite packages:

    $ npm install -g coffee-script
    $ npm install less --save

To update NPM:

    $ npm install npm -g


### Nginx

    $ brew install nginx
    $ sudo ln -sfv /usr/local/opt/nginx/*.plist /Library/LaunchAgents
    $ sudo mkdir /var/log/nginx/

Edit `/usr/local/etc/nginx/nginx.conf`, change port to 80 and error_log to `/var/log/nginx/error.log`. Then start the server:

    $ sudo nginx

Config file:

    /usr/local/etc/nginx/nginx.conf

Other commands:

    $ sudo nginx -s stop
    $ sudo nginx -s reload

### PHP-FPM

    $ brew tap josegonzalez/homebrew-php
    $ brew tap homebrew/dupes
    $ brew install php55 --with-mysql --with-fpm
    $ ln -sfv /usr/local/opt/php55/*.plist ~/Library/LaunchAgents
    $ launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist

Example Nginx config (place in `server` directive):

    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include        fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

Config files:

    /usr/local/etc/php/5.5/php-fpm.conf
    /usr/local/etc/php/5.5/php.ini

Starting and stopping the server:

    $ launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist
    $ launchctl unload -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist


### LaunchRocket
[LaunchRocket](https://github.com/jimbojsb/launchrocket) is a Mac PreferencePane for managing services with launchd. It's pretty handy for MySQL, PHP-FPM, Nginx, etc.

    $ brew install caskroom/cask/brew-cask
    $ brew cask install launchrocket


## Thanks to...
* Mathias Bynens for sharing [his dotfiles](https://github.com/mathiasbynens/dotfiles), bootstrap script and installation instructions.
* Michael Moyle for his Nginx/PHP-FPM [installation instructions](http://michaelmoyle.blogspot.com/2013/01/install-php-with-nginx-and-php-fpm.html).
