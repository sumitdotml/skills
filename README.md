# Skills

Agent skills for personal use.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/sumitdotml/skills/main/install.sh | bash
```

Installer behavior:
- Skills are installed to `.agents/skills`.
- Hooks are installed to `.agents/hooks/` and wired into `.agents/settings.local.json`.
- The installer sets `.claude` as a symlink to `.agents` (asks before replacing an existing non-symlink).
- The installer creates `AGENTS.md` and `AGENT_MISTAKES.md` if missing.
- If `AGENTS.md` already exists, the installer asks before appending guardrails.
- The installer creates `CLAUDE.md` as a symlink to `AGENTS.md` (asks before replacing an existing non-symlink).

## Available Skills

- **coding-principles** - Behavioral guidelines to reduce common LLM coding mistakes
- **commit** - Commit current work to git with concise, well-formatted commit messages
- **mistake-memory-guardrails** - Global mistake-memory guardrails across code, docs, tests, config, and planning edits
- **model-debate** - Multi-model convergence planning via structured AI debate
- **read-arxiv-paper** - taken from Karpathy's nanochat GitHub; for quickly getting arxiv paper summaries
- **tinygrad** - A minimal tensor library with autograd, JIT compilation, and multi-device support
- **writing-style** - Writing style guidelines for technical and blog-style content

## Hooks

PreToolUse hooks that block unsafe Bash commands (installed to `.agents/hooks/`):

- **block-dangerous-git.sh** - Blocks `git push`, `git reset --hard`, `git clean -f`, `git branch -D`, `git checkout .`, `git restore .`
- **block-pip.sh** - Blocks `pip`/`pip3`/`python -m pip`; use `uv` instead
