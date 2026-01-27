#!/usr/bin/env bash
set -e

REPO="https://github.com/sumitdotml/skills.git"
DEST="$HOME/.claude/skills"
TMP=$(mktemp -d)

git clone --depth 1 --quiet "$REPO" "$TMP"
mkdir -p "$DEST"
cp -r "$TMP/skills/"* "$DEST/"
rm -rf "$TMP"

echo "Installed skills to $DEST"
