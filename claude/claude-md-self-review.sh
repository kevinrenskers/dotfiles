#!/usr/bin/env bash
# Fires before every Bash tool call. When the command is a git commit, injects the
# "Self-review before committing" section of the CLAUDE.md next to this script so the
# diff gets read before it is committed. The section is read at runtime, so CLAUDE.md
# stays the only copy.
set -uo pipefail

# Emit the checklist (or, when it cannot be found, a warning plus a fallback
# instruction so the commit is still reviewed against CLAUDE.md by hand).
emit() {
  jq -n --arg context "$1" --arg warning "${2:-}" '
    {hookSpecificOutput: {hookEventName: "PreToolUse", additionalContext: $context}}
    + (if $warning == "" then {} else {systemMessage: $warning} end)
  '
  exit 0
}

FALLBACK="Self-review before committing: this hook could not read the checklist out of
CLAUDE.md, so read the file's \"Self-review before committing\" section yourself and check
\`git diff --cached\` against it before committing."

command=$(jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

case "$command" in
*"git commit"*) ;;
*) exit 0 ;;
esac

claude_md="$(dirname "$0")/CLAUDE.md"
[ -r "$claude_md" ] || emit "$FALLBACK" "Self-review hook: cannot read $claude_md, so it is falling back to a generic reminder instead of the checklist."

# Print the section from its heading up to the next one.
checklist=$(awk '
  /^##+ / {
    if (inside) exit
    if ($0 == "### Self-review before committing") inside = 1
  }
  inside { print }
' "$claude_md")

# Nothing but the heading means the section was renamed or removed.
if [ "$(printf '%s\n' "$checklist" | wc -l)" -le 1 ]; then
  emit "$FALLBACK" "Self-review hook: no '### Self-review before committing' section in $claude_md — it was renamed or removed, so the hook is falling back to a generic reminder instead of the real checklist. Fix the heading or update $0."
fi

emit "$checklist"
