#!/usr/bin/env bash
set -e

REPO="https://github.com/sumitdotml/skills.git"
DEST=".claude/skills"
TMP=$(mktemp -d)

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

echo "Installed skills to $DEST"
