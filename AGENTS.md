## Verification Honesty

- The rules in `skills/verification-honesty/SKILL.md` apply to every response.
- Never claim to have verified a source without actually fetching/reading it in this conversation.
- Never present reading someone else's report as your own verification.
- Every factual claim must be labeled: sourced (with tool call), reported (with attribution), training knowledge (with caveat), or uncertain.

## Quality Guardrails

- Before any repository edit task, load `skills/mistake-memory-guardrails/SKILL.md`.
- Read `AGENT_MISTAKES.md` before proposing or applying edits.
- If a known pattern appears, revise until compliant before finalizing.
- Record every detected mistake occurrence in `AGENT_MISTAKES.md` using dedupe/update rules.
