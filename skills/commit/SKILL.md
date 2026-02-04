---
name: commit
description: Commit current work with proper formatting. Use when the user asks to commit, save progress, or checkpoint their work.
---

Commit current work to git with properly formatted messages.

## Commit Message Format

- First letter lowercase
- First word past tense (e.g., "added", "updated", "fixed", "removed")
- Proper nouns/acronyms capitalized as needed (e.g., "MMLU-Pro", "GPT-2")
- Common words like "readme" can stay lowercase.
- Decisions on which kinds of words to capitalize and which ones to keep as lowercases are generally left to the vibes of the AI Model (信頼です)

Examples:

- `added dataset verification script`
- `fixed gradient flow in MoE router`
- `updated readme with setup instructions`

## Instructions

1. Run `GIT_EDITOR=true git status` to see what changed
2. Run `GIT_EDITOR=true git diff <file>` for each modified file to review changes
3. Group related changes into logical commits
4. For each commit:
   - Stage only related files (avoid `git add -A`)
     e commit message: - Short title (< 80 chars) - If meaningful changes: 2-3 bullet points - If minor changes: single line, no bullets
5. After committing, if not on main, ask if user wants to push

## Important

- Prepend `GIT_EDITOR=true` to git commands to avoid blocking
- If git diff isn't helpful, use working memory of recent changes
- Only commit when instructed — don't auto-commit subsequent work
- Avoid verbosity — keep messages concise
