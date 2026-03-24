# AGENT_MISTAKES

Mistake memory for future repository edits.

Initialized on 2026-03-24.

## Rules

- Read this file before any repository edit task.
- Record each detected mistake occurrence.
- Deduplicate by normalized `pattern` + `scope_tags` + `prevention_rule`.
- Update matching entries instead of creating duplicates.
- `active` means keep checking for this pattern in future work.
- `resolved` means keep the lesson, but do not treat it as currently open.

## Entry Shape

```md
### MISTAKE-YYYYMMDD-001

- status: active | resolved
- severity: low | medium | high
- scope_tags: [code, docs, tests, config, infra, planning]
- pattern: normalized mistake pattern
- prevention_rule: specific action that prevents recurrence
- validation_check: deterministic pass/fail check
- first_seen: YYYY-MM-DD
- last_seen: YYYY-MM-DD
- occurrence_count: 1
- evidence:
  - file:relative/path:line
  - commit:hash
```
