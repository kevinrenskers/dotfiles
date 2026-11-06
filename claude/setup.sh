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

HOOK="\"$(realpath claude-md-self-review.sh)\""
SETTINGS="$HOME/.claude/settings.json"

[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

if jq -e --arg cmd "$HOOK" '[.hooks.PreToolUse[]?.hooks[]?.command] | index($cmd)' "$SETTINGS" > /dev/null; then
    echo "Self-review hook already present in $SETTINGS"
else
    TMP="$(mktemp)"
    if jq --arg cmd "$HOOK" '.hooks.PreToolUse += [{
        matcher: "Bash",
        hooks: [{
            type: "command",
            command: $cmd,
            statusMessage: "Checking the diff against CLAUDE.md",
            timeout: 10
        }]
    }]' "$SETTINGS" > "$TMP"; then
        cat "$TMP" > "$SETTINGS"
        echo "Added self-review hook to $SETTINGS"
    else
        echo "Could not add self-review hook to $SETTINGS"
    fi
    rm "$TMP"
fi
