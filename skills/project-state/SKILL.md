---
name: project-state
description: Reconstruct the current state of an active project and present it as a compact but comprehensive bullet snapshot. Use when asked things like "where are we currently?", "give me the current state", "what is done and what is left?", "summarize the project checkpoint", or "give me the latest bullets on every detail" for research projects, application builds, planning-heavy repos, or other ongoing work.
---

# Project State

jroduce a fresh status snapshot from repository state, not memory.

## Sources Of Truth

Identify the repo's live sources of truth before summarizing. Prefer this search order unless the request is narrower:

1. live execution tracker:
   - `TODO.md`
   - `TASKS.md`
   - `PLAN.md`
   - similarly named active tracker files
2. higher-level project framing:
   - `PROJECT_PLAN.md` (or similar)
   - `README.md`
   - design docs
   - proposal docs
3. chronological notes:
   - `LOG.md`
   - `NOTES.md`
   - research journal files
4. freeze or spec docs:
   - `docs/freeze/*.md`
   - `specs/`
   - contract docs
5. retained artifacts or data manifests:
   - `artifacts/`
   - `data/`
   - run manifests
   - audit reports
6. repo state:
   - `git status --short`
   - recent commits when current branch state matters

Treat these roles as binding:

- live tracker: current execution truth
- planning doc: higher-level framing and constraints
- log or notes: chronology and recent decisions
- freeze or spec docs: binding contracts and exact settings
- artifacts or manifests: retained evidence, datasets, outputs, or evaluations

## Workflow

1. Rebuild the current state from files, not from prior replies.
2. Distinguish clearly between:
   - frozen
   - provisional
   - open
   - archived
3. Prefer exact values when present:
   - counts
   - versions
   - costs
   - dates
   - seeds
   - artifact paths
   - benchmark names
   - deployment targets
4. If a detail was not checked in this turn, say so instead of guessing.
5. If the worktree is dirty, say which files are changed.
6. Adapt the summary to the repo type:
   - research: datasets, benchmarks, specs, experiments
   - application: implemented features, open tasks, environments, deploy state
   - mixed projects: both

## Output Shape

Use only the sections that fit the repo. Default candidates:

- `Current State`
- `Core Artifacts`
- `Data / Inputs`
- `Quality / Validation`
- `Specs / Freeze Docs`
- `Implementation Status`
- `Experiment Contract` or `Execution Contract`
- `Deploy / Runtime State`
- `What Is Done`
- `What Is Not Done Yet`
- `Immediate Next Step`
- `Repo / Git State`

Use flat bullets only. Keep each bullet concrete and self-contained.

## Style Rules

- Lead with facts, not commentary.
- Prefer terse bullets over paragraphs.
- Name the canonical files and artifact paths when they matter.
- Do not imply that a contract is frozen unless the relevant source says so.
- Do not blur live tasks with completed work.
- Do not present archived files as live planning documents.
- If two files disagree, say so explicitly and identify the likely live source of truth.

## Common Things To Capture

Capture whichever of these are relevant:

- core objective
- current phase
- key locked decisions
- exact artifacts in play
- completed milestones
- unresolved risks
- next execution step
- current repo cleanliness and latest commits when useful

If the user asks again after a project milestone, rerun the file reads and rebuild the snapshot from scratch.
