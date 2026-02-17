# Skills

Agent skills for personal use.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/sumitdotml/skills/main/install.sh | bash
```

Installer behavior:
- Skills are installed to `.agents/skills`.
- The installer sets `.claude` as a symlink to `.agents`.
- If `.claude` already exists as a normal directory/file, the installer asks for confirmation before replacing it with the symlink.

## Available Skills

- **model-debate** - Multi-model convergence planning via structured AI debate
- **coding-principles** - Behavioral guidelines to reduce common LLM coding mistakes
- **tinygrad** - A minimal tensor library with autograd, JIT compilation, and multi-device support
- **read-arxiv-paper** - taken from Karpathy's nanochat GitHub; for quickly getting arxiv paper summaries
