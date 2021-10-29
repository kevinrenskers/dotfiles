# Mac OS X setup

This is a list of reproducible steps to get a clean Mac up and running with nice dotfiles for Fish, plus a whole bunch of apps and development tools.

![Fish theme](screenshot.png)

## Step 1: ssh keys

Restore your saved ssh keys or [create a new pair](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

## Step 2: install Homebrew and git

    $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    $ brew analytics off

## Step 3: dotfiles

Clone this repository

    $ git clone git@github.com:kevinrenskers/dotfiles.git

And run the `bootstrap.sh` script. Alternatively, only run the `setup.sh` scripts in specific subfolders if you don't need everything.

**Restart your shell after it's done.**

You can now run `fish_config` to change the terminal colors, abbreviations, etc.

Don't forget to set your git credentials, or you'll be using my details which are in the dotfiles:

    $ git config --global user.name "Kevin Renskers"
    $ git config --global user.email "kevin@loopwerk.io"

## Step 4: anything else you need

### Keyfixer

[This tool](http://www.starryhope.com/keyfixer/) makes the Home and End keys on your full keyboard a lot better.

### Python

I'm using [Homebrew's Python](https://docs.brew.sh/Homebrew-and-Python.html).

    $ brew install python

A great package to install:

    $ pip3 install git-up

Upgrade pip or setuptools itself:

    $ pip3 install --upgrade pip
    $ pip3 install --upgrade setuptools

### Ruby

I'm using rbenv instead of the system Ruby, to prevent annoying permission problems. You should never have to use `sudo` to install gems!

```
brew install rbenv
rbenv init
```

Follow the printed instructions to set up rbenv shell integration. Close your terminal and open a new one so the changes take effect. Then verify that everything is okay:

```
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

Now you can install (and then use) a Ruby version, for example:

```
rbenv install 2.6.4
rbenv global 2.6.4
```

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

    $ npm install -g raml2html
    $ npm install less --save

To update NPM:

    $ npm install npm -g

### Nginx

    $ brew install nginx
    $ sudo ln -sfv /usr/local/opt/nginx/*.plist /Library/LaunchAgents
    $ sudo mkdir /var/log/nginx/

Edit `/usr/local/etc/nginx/nginx.conf`, change `port` to `80` and `error_log` to `/var/log/nginx/error.log`. Then start the server:

    $ sudo nginx

Config file:

    /usr/local/etc/nginx/nginx.conf

Other commands:

    $ sudo nginx -s stop
    $ sudo nginx -s reload

## Thanks to...

- Mathias Bynens for sharing [his dotfiles](https://github.com/mathiasbynens/dotfiles), bootstrap script and installation instructions.
- Michael Moyle for his Nginx/PHP-FPM [installation instructions](http://michaelmoyle.blogspot.com/2013/01/install-php-with-nginx-and-php-fpm.html).
- Rosco Kalis for sharing [hit dotfiles](https://github.com/rkalis/dotfiles)
