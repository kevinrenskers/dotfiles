# Mac OS X setup

This is a list of reproducible steps to get a clean Mac (with Apple Silicon) up and running with nice dotfiles for Fish, plus a whole bunch of apps and development tools.

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

### Python

I'm using [Poetry](https://python-poetry.org) as the package manager and environment manager for Python projects, together with [pyenv](https://github.com/pyenv/pyenv) to install specific versions of Python. I do not use Homebrew to install Python, nor do I use the system version of Python.

Start by installing pyenv:

    $ brew install pyenv

Then install a Python version, for example 3.10:

    $ pyenv install 3.10
    $ pyenv global 3.10

Make sure it works:

    $ which python3
    $ python3 --version

They should point to the version installed in the `.pyenv` folder and of course match the version you specified. Now we can install Poetry:

    $ curl -sSL https://install.python-poetry.org | python3 -

And to make sure it works:

    $ poetry --version

Some useful settings to enable:

    $ poetry config virtualenvs.in-project true
    $ poetry config virtualenvs.prefer-active-python true

These settings will make working with local Python versions via pyenv a lot easier, and make it a lot easier to nuke the `.venv` folder within a project to reinstall your dependencies.

### git up

I love [git up](https://github.com/msiemens/PyGitUp), which updates all local branches with remote changes, by rebasing rather than merging. You just run `git up` in your project and everything is up to date.

After installing Python, you can simply install git up with one command:

    $ pip install git-up

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

Simply download Postgress.app from http://postgresapp.com.

### Node.js and NPM (Node Package Manager)

I'm using [pnpm](https://pnpm.io) as my Node package manager, and to install specific Node versions.

    $ curl -fsSL https://get.pnpm.io/install.sh | sh -
    $ pnpm env use --global lts

Restart your shell and check if everything works: `node --version`.

To update pnpm itself:

    $ pnpm add -g pnpm

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
