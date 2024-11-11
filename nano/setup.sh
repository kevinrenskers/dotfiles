#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

# Install nano
brew nano

# Get the syntax highlighting files
git clone git@github.com:galenguyer/nano-syntax-highlighting.git ~/.nano

# Copy dotfiles
. ../scripts/symlink.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~)"

echo "Source path:\t\t $SOURCE"
echo "Destination path:\t $DESTINATION"

find . -name ".nano*" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
