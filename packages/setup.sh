#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

# Install Brewfile contents
brew bundle
