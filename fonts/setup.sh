#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/Library/Fonts)"

echo "Source path:\t\t $SOURCE"
echo "Destination path:\t $DESTINATION"

find * -name "*.ttf" -o -name "*.otf" | while read fn; do
    cp "$SOURCE/$fn" "$DESTINATION/$fn"
done
