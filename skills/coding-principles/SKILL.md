---
name: coding-principles
description: Behavioral guidelines to reduce common LLM coding mistakes. Emphasizes thinking before coding, simplicity, surgical changes, and goal-driven execution. Load this when writing or modifying code to avoid overengineering and unnecessary changes.
user-invocable: true
---

# Coding Principles

Behavioral guidelines to reduce common LLM coding mistakes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Minimal Comments

**Code should be self-documenting. Comments are a last resort.**

- Remove comments that state the obvious (e.g., `# Save the file` before `file.save()`)
- Remove section header comments (e.g., `# Configuration`, `# Helper functions`)
- Keep docstrings for public APIs (functions, classes) with Args/Returns
- Keep comments only when explaining non-obvious _why_, not _what_

When a comment is necessary:

- First word must be lowercase (e.g., `# handling edge case` not `# Handling edge case`)
- Use -ing form (e.g., `# parsing response` not `# Parse response`)

Examples:

```python
# bad - stating the obvious
# Get the user
user = get_user(id)

# bad - capitalized, imperative
# Parse the JSON response
data = json.loads(response)

# good - lowercase, -ing, explains why
# handling malformed responses from legacy API
if "data" not in response:
    response = {"data": response}
```

## 6. Avoid AI Slop

**Before committing, review your diff for LLM-specific anti-patterns.**

Common AI code smells to remove:

- Type casts to `any` (TS) or `# type: ignore` (Python) to silence errors instead of fixing them
- Overly verbose variable names or redundant intermediate variables
- "Just in case" fallbacks that can never trigger given the call site
- Inconsistent style with surrounding code (see Section 3)
- Redundant comments (see Section 5)

Review workflow: Check your diff against main and ask "Would a human have written this?" If code looks defensive, verbose, or out of place—it's probably AI slop. Remove it.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
