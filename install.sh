#!/usr/bin/env bash
set -e

REPO="https://github.com/sumitdotml/skills.git"
AGENTS_DIR=".agents"
CLAUDE_LINK=".claude"
DEST="$AGENTS_DIR/skills"
TMP=$(mktemp -d)

echo "Fetching skills..."
git clone --depth 1 --quiet "$REPO" "$TMP"

existing=()
for skill in "$TMP/skills/"*/; do
  name=$(basename "$skill")
  [ -d "$DEST/$name" ] && existing+=("$name")
done

if [ ${#existing[@]} -gt 0 ]; then
  echo "Warning: These skills already exist and will be overwritten:"
  printf '  - %s\n' "${existing[@]}"
  read -p "Continue? [y/N] " -n 1 -r
  echo
  [[ ! $REPLY =~ ^[Yy]$ ]] && { rm -rf "$TMP"; echo "Aborted."; exit 1; }
fi

mkdir -p "$DEST"
cp -r "$TMP/skills/"* "$DEST/"
rm -rf "$TMP"

if [ -e "$CLAUDE_LINK" ] && [ ! -L "$CLAUDE_LINK" ]; then
  echo "Warning: $CLAUDE_LINK exists and is not a symlink."
  read -p "Replace it with a symlink to $AGENTS_DIR? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$CLAUDE_LINK"
    echo "Removed existing $CLAUDE_LINK"
  else
    echo "Keeping existing $CLAUDE_LINK unchanged."
    echo "Installed skills are available at $DEST."
    exit 0
  fi
fi
ln -sfn "$AGENTS_DIR" "$CLAUDE_LINK"

echo "Installed to $DEST:"
for skill in "$DEST/"*/; do
  echo "  - $(basename "$skill")"
done
