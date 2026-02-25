#!/usr/bin/env bash
set -e

REPO="https://github.com/sumitdotml/skills.git"
AGENTS_DIR=".agents"
CLAUDE_LINK=".claude"
DEST="$AGENTS_DIR/skills"
HOOKS_DEST="$AGENTS_DIR/hooks"
SETTINGS_LOCAL="$AGENTS_DIR/settings.local.json"
ROOT_AGENTS_FILE="AGENTS.md"
ROOT_MISTAKES_FILE="AGENT_MISTAKES.md"
ROOT_CLAUDE_FILE="CLAUDE.md"
TMP=$(mktemp -d)

echo "Fetching skills..."
git clone --depth 1 --quiet "$REPO" "$TMP"

SKILLS_SRC="$TMP/skills"
HOOKS_SRC="$TMP/hooks"
AGENTS_SRC="$TMP/$ROOT_AGENTS_FILE"
MISTAKES_SRC="$TMP/$ROOT_MISTAKES_FILE"

existing=()
for skill in "$SKILLS_SRC/"*/; do
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
cp -r "$SKILLS_SRC/"* "$DEST/"

if [ -f "$AGENTS_SRC" ]; then
  guardrails_header=$(grep -m1 '^## ' "$AGENTS_SRC" || true)
  if [ -e "$ROOT_AGENTS_FILE" ]; then
    if [ -n "$guardrails_header" ] && grep -Fqx "$guardrails_header" "$ROOT_AGENTS_FILE"; then
      echo "$ROOT_AGENTS_FILE already has ${guardrails_header#\#\# } section; keeping existing file."
    else
      echo "Warning: $ROOT_AGENTS_FILE already exists."
      read -p "Append quality guardrails section to $ROOT_AGENTS_FILE? [y/N] " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        printf "\n" >> "$ROOT_AGENTS_FILE"
        cat "$AGENTS_SRC" >> "$ROOT_AGENTS_FILE"
        echo "Updated $ROOT_AGENTS_FILE"
      else
        echo "Keeping existing $ROOT_AGENTS_FILE unchanged."
      fi
    fi
  else
    cp "$AGENTS_SRC" "$ROOT_AGENTS_FILE"
    echo "Created $ROOT_AGENTS_FILE"
  fi
else
  echo "Warning: $ROOT_AGENTS_FILE template not found in source repo; skipping."
fi

if [ -f "$MISTAKES_SRC" ]; then
  if [ -e "$ROOT_MISTAKES_FILE" ]; then
    echo "$ROOT_MISTAKES_FILE already exists; keeping existing file."
  else
    cp "$MISTAKES_SRC" "$ROOT_MISTAKES_FILE"
    echo "Created $ROOT_MISTAKES_FILE"
  fi
else
  echo "Warning: $ROOT_MISTAKES_FILE template not found in source repo; skipping."
fi

if [ ! -e "$ROOT_AGENTS_FILE" ] && [ ! -L "$ROOT_AGENTS_FILE" ]; then
  echo "Warning: $ROOT_AGENTS_FILE is missing; skipping $ROOT_CLAUDE_FILE symlink setup."
else
  if [ -e "$ROOT_CLAUDE_FILE" ] && [ ! -L "$ROOT_CLAUDE_FILE" ]; then
    echo "Warning: $ROOT_CLAUDE_FILE exists and is not a symlink."
    read -p "Replace it with a symlink to $ROOT_AGENTS_FILE? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -rf "$ROOT_CLAUDE_FILE"
      ln -s "$ROOT_AGENTS_FILE" "$ROOT_CLAUDE_FILE"
      echo "Created $ROOT_CLAUDE_FILE -> $ROOT_AGENTS_FILE"
    else
      echo "Keeping existing $ROOT_CLAUDE_FILE unchanged."
    fi
  elif [ -L "$ROOT_CLAUDE_FILE" ]; then
    current_target=$(readlink "$ROOT_CLAUDE_FILE")
    if [ "$current_target" != "$ROOT_AGENTS_FILE" ]; then
      echo "Warning: $ROOT_CLAUDE_FILE points to $current_target."
      read -p "Retarget it to $ROOT_AGENTS_FILE? [y/N] " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        ln -sfn "$ROOT_AGENTS_FILE" "$ROOT_CLAUDE_FILE"
        echo "Updated $ROOT_CLAUDE_FILE -> $ROOT_AGENTS_FILE"
      else
        echo "Keeping existing $ROOT_CLAUDE_FILE unchanged."
      fi
    fi
  else
    ln -s "$ROOT_AGENTS_FILE" "$ROOT_CLAUDE_FILE"
    echo "Created $ROOT_CLAUDE_FILE -> $ROOT_AGENTS_FILE"
  fi
fi

setup_claude_link=true
if [ -e "$CLAUDE_LINK" ] && [ ! -L "$CLAUDE_LINK" ]; then
  echo "Warning: $CLAUDE_LINK exists and is not a symlink."
  read -p "Replace it with a symlink to $AGENTS_DIR? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$CLAUDE_LINK"
    echo "Removed existing $CLAUDE_LINK"
  else
    echo "Keeping existing $CLAUDE_LINK unchanged."
    setup_claude_link=false
  fi
fi

if [ "$setup_claude_link" = true ]; then
  ln -sfn "$AGENTS_DIR" "$CLAUDE_LINK"
fi

# install hooks
if [ -d "$HOOKS_SRC" ]; then
  existing_hooks=()
  for hook in "$HOOKS_SRC/"*.sh; do
    [ -f "$hook" ] || continue
    name=$(basename "$hook")
    [ -f "$HOOKS_DEST/$name" ] && existing_hooks+=("$name")
  done

  if [ ${#existing_hooks[@]} -gt 0 ]; then
    echo "Warning: These hooks already exist and will be overwritten:"
    printf '  - %s\n' "${existing_hooks[@]}"
    read -p "Continue? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Skipping hooks installation."
      existing_hooks=("__skip__")
    fi
  fi

  if [ "${existing_hooks[0]}" != "__skip__" ]; then
    mkdir -p "$HOOKS_DEST"
    cp "$HOOKS_SRC/"*.sh "$HOOKS_DEST/"
    chmod +x "$HOOKS_DEST/"*.sh

    # wire up settings.local.json with hook entries
    hook_commands=()
    for hook in "$HOOKS_DEST/"*.sh; do
      [ -f "$hook" ] || continue
      name=$(basename "$hook")
      hook_commands+=("{\"type\":\"command\",\"command\":\"\$CLAUDE_PROJECT_DIR/.claude/hooks/$name\"}")
    done

    if [ ${#hook_commands[@]} -gt 0 ]; then
      hooks_json=$(printf '%s,' "${hook_commands[@]}")
      hooks_json="[${hooks_json%,}]"
      hooks_tmp=$(mktemp)
      echo "$hooks_json" > "$hooks_tmp"

      if [ -f "$SETTINGS_LOCAL" ]; then
        if grep -q '"hooks"' "$SETTINGS_LOCAL"; then
          echo "$SETTINGS_LOCAL already has hooks config; keeping existing."
        else
          jq --slurpfile h "$hooks_tmp" '.hooks = {"PreToolUse": [{"matcher": "Bash", "hooks": $h[0]}]}' "$SETTINGS_LOCAL" > "$SETTINGS_LOCAL.tmp"
          mv "$SETTINGS_LOCAL.tmp" "$SETTINGS_LOCAL"
          echo "Updated $SETTINGS_LOCAL with hooks."
        fi
      else
        echo '{}' | jq --slurpfile h "$hooks_tmp" '.hooks = {"PreToolUse": [{"matcher": "Bash", "hooks": $h[0]}]}' > "$SETTINGS_LOCAL"
        echo "Created $SETTINGS_LOCAL with hooks."
      fi

      rm -f "$hooks_tmp"
    fi

    echo "Installed hooks to $HOOKS_DEST:"
    for hook in "$HOOKS_DEST/"*.sh; do
      echo "  - $(basename "$hook")"
    done
  fi
fi

rm -rf "$TMP"

echo "Installed skills to $DEST:"
for skill in "$DEST/"*/; do
  echo "  - $(basename "$skill")"
done
