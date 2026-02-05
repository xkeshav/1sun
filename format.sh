#!/bin/bash
set -euo pipefail

ISSUE_NUMBER="$1"
OLD_TITLE="$2"
PREFIX="${3:-GEN}" # fallback if not passed

YEAR=$(date +%y)
PADDED_NUM=$(printf "%04d" "$ISSUE_NUMBER")
IDENTIFIER="[${PREFIX}-${YEAR}${PADDED_NUM}]: "

# Skip by checking the prefix

if [[ "$OLD_TITLE" =~ \[${PREFIX}-[0-9]{6}\] ]]; then
  echo "Title already contains formatted ID [${PREFIX}-XXXXXX]. Skipping."
  exit 0
fi

# Insert after emoji if present
if [[ "$OLD_TITLE" =~ ^([[:space:]]*[^[:alnum:][:space:]]+[[:space:]]*)(.*) ]]; then
  EMOJI="${BASH_REMATCH[1]}"
  REST="${BASH_REMATCH[2]}"
  NEW_TITLE="${EMOJI} ${IDENTIFIER}${REST}"
else
  NEW_TITLE="${IDENTIFIER}${OLD_TITLE}"
fi

# Normalize spacing 
NEW_TITLE=$(echo "$NEW_TITLE" | sed -E 's/[[:space:]]+/ /g; s/^ | $//g')

echo "New title would be: $NEW_TITLE"


gh issue edit "$ISSUE_NUMBER" --title "$NEW_TITLE" --repo "${GITHUB_REPOSITORY}"
echo "Title updated successfully."
