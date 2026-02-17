---
name: mistake-memory-guardrails
description: Prevent repeated agent mistakes across code, docs, tests, and configs by enforcing repository mistake memory before edits and recording new failures.
user-invocable: true
---

# Mistake Memory Guardrails

Global guardrails for repository edit tasks.

## Scope

Apply this skill to any repository edit task, including code, docs, tests, config, infra, and planning files.

## Execution Order

1. Read `AGENT_MISTAKES.md`. If missing, create it using the required schema.
2. Read target files and map applicable `scope_tags`.
3. Run guardrail checks before proposing or applying changes.
4. Run a post-edit self-check against known mistake patterns before final response.
5. Record every detected mistake occurrence.

## Guardrail Checks

1. Requirement fidelity and scope discipline:
- Change only what the user requested.
- Reject unrelated refactors and speculative additions.

2. Cross-file consistency for shared facts/configs/interfaces:
- Keep shared names, paths, status values, and contracts aligned across touched files.
- Flag stale duplicated facts and mismatched defaults.

3. Assertion quality:
- Replace vague claims with measurable criteria.
- Require explicit thresholds, formulas, or pass/fail conditions when asserting quality or correctness.

4. Reproducibility metadata when claims depend on run conditions:
- For benchmark/performance/behavior claims, capture model/tool version, dataset revision, seed, environment, and run conditions when relevant.
- Separate deterministic correctness checks from environment-sensitive comparisons.

5. Safety and regression checks:
- Verify edits do not silently break existing behavior.
- Call out potential regressions and missing validation coverage.

## Mistake Recording Rules

- Record every detected mistake occurrence.
- Deduplicate by normalized `pattern` + `scope_tags` + `prevention_rule`.
  - Normalization: lowercase, trim whitespace, collapse repeated spaces.
- If a deduplicated entry exists:
  - Increment `occurrence_count`.
  - Update `last_seen`.
  - Append new evidence (file:line and/or commit).
- If no matching entry exists:
  - Append a new entry with all required fields from `AGENT_MISTAKES.md`.

## Enforcement Behavior

- If a known rule is violated, warn and revise the proposal before final response.
- Fix violations before finalizing whenever possible.
- If unresolved, explicitly report the risk and why it could not be fully resolved.

## Output Contract

When reporting results, provide:

1. What was checked.
2. What was changed and why.
3. Remaining risks or unresolved ambiguities.
4. Whether `AGENT_MISTAKES.md` was created or updated.
