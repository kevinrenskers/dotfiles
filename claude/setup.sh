#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

# Imported rather than symlinked, so personal rules can be added below the import.
SOURCE="$(realpath CLAUDE.md)"
DESTINATION="$HOME/.claude/CLAUDE.md"
IMPORT="@$SOURCE"

printf "Source path:\t\t %s\n" "$SOURCE"
printf "Destination path:\t %s\n" "$DESTINATION"

mkdir -p "$(dirname "$DESTINATION")"

if [ ! -f "$DESTINATION" ]; then
    echo "$IMPORT" > "$DESTINATION"
    echo "Created $DESTINATION"
elif grep -qxF "$IMPORT" "$DESTINATION"; then
    echo "Import already present in $DESTINATION"
else
    TMP="$(mktemp)"
    { echo "$IMPORT"; echo; cat "$DESTINATION"; } > "$TMP"
    cat "$TMP" > "$DESTINATION"
    rm "$TMP"
    echo "Added import to the top of $DESTINATION"
fi
