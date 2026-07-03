---
title: "Frequently asked questions — Claude Code"
description: "Common questions when installing and using Claude Code: Node.js, size, authentication, free plan, updates and uninstalling."
---

# Frequently asked questions

## Do I need Node.js?

**No**, if you use the **native installer** (recommended) or Homebrew/WinGet: they download a
self-contained binary. **Yes**, only if you install via `npm` (Node 18+).

## How big is the installation?

The Claude Code binary is **a single file (~238 MB)** — it doesn't drag in dependency trees or
build tools. Over time, the auto-update may accumulate old versions in
`~/.local/share/claude/versions/`; free them up with the
[`claude_cleanup.sh`](https://github.com/varelaia/Claude-Installer/blob/main/scripts/claude_cleanup.sh)
script.

## Does it work with the free Claude.ai plan?

No. Claude Code requires a **Pro, Max, Team or Enterprise** subscription, or a **Console**
account with API access (or an enterprise provider: Bedrock/Vertex/Foundry).

## How do I sign in?

Run `claude` in any project: the browser opens to authenticate you. Within a session you can
re-authenticate with `/login`.

## How does it update?

- **Native installer:** auto-updates in the background (`latest` channel by default; you can
  switch to `stable`).
- **Homebrew:** manual → `brew upgrade claude-code`.
- **npm:** manual → `npm install -g @anthropic-ai/claude-code@latest` (don't use `npm update -g`).
- **WinGet:** manual → `winget upgrade Anthropic.ClaudeCode`.

## How do I verify it installed correctly?

```bash
claude --version
claude doctor
```

## How do I uninstall it?

Delete the binary and its data:

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
```

On Windows: delete `%USERPROFILE%\.local\bin\claude.exe` and `%USERPROFILE%\.local\share\claude`.
If you installed via Homebrew/npm/WinGet, uninstall through that manager.

## What's the difference between this repo and the official commands?

None in the binary: we use Anthropic's **official installer**. This repo only adds scripts that
**ensure the PATH**, verify the result, and document requirements and common problems in one
place.
