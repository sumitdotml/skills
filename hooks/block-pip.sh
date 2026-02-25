#!/bin/bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

if echo "$COMMAND" | grep -qE '(^|;|&&|\|\||\|)\s*pip[0-9]?\s' || echo "$COMMAND" | grep -qE 'python[0-9.]* -m pip\s'; then
  echo "BLOCKED: pip is not allowed. Use 'uv' instead (e.g. 'uv add', 'uv sync', 'uv run'). No venv activation needed." >&2
  exit 2
fi

exit 0
