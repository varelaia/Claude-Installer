---
title: "Technical manual — Claude Code"
description: "Architecture of the Claude Code installation: native binary, location, PATH, auto-update, version channels, authentication and configuration."
---

# Technical manual

## What it is

**Claude Code** is an agentic CLI by Anthropic. The native installer delivers **a
self-contained binary** — it's not an interpreted Node package; the installed `claude` **does
not invoke Node.js** at runtime.

## Installation methods and what they deliver

| Method | What it downloads | Node required |
|---|---|---|
| Native installer (`install.sh`/`.ps1`/`.cmd`) | native binary | no |
| npm (`@anthropic-ai/claude-code`) | the **same** native binary via platform-specific optional dependencies (`…-darwin-arm64`, `…-linux-x64`, …) | yes, 18+ (only to install) |
| Homebrew cask (`claude-code`) | pre-compiled binary (cask, not formula) | no |
| WinGet (`Anthropic.ClaudeCode`) | native binary | no |

## Location and PATH

- **Binary:** `~/.local/bin/claude` (symlink) → `~/.local/share/claude/versions/<version>`.
  On Windows: `%USERPROFILE%\.local\bin\claude.exe`.
- **Data/versions:** `~/.local/share/claude/` (Windows: `%USERPROFILE%\.local\share\claude\`).
- The native installer adds `~/.local/bin` to the `PATH` automatically. If the shell doesn't
  pick it up, it's persisted by hand in the profile (`~/.zshrc`/`~/.bashrc`/user PATH).

## Auto-update and channels

- The native installer **auto-updates** in the background (it checks at startup).
- Channels: `latest` (default) and `stable` (~1 week behind, avoids regressions). Switch with
  `/config` → "Auto-update channel" or in `settings.json`:
  ```json
  { "autoUpdatesChannel": "stable" }
  ```
- Each update leaves the previous version in `versions/` (cleanup: `claude_cleanup.sh`).
- Homebrew/WinGet/npm do **not** auto-update (manual update).

## Authentication

`claude` opens the browser for OAuth with the account (Pro/Max/Team/Enterprise or Console API).
Credentials are stored locally (persistent login). Enterprise providers: Amazon Bedrock, Google
Vertex AI, Microsoft Foundry.

## Configuration

`settings.json` controls behavior (update channel, ripgrep on Alpine with
`"USE_BUILTIN_RIPGREP": 0`, Git Bash path on Windows with `CLAUDE_CODE_GIT_BASH_PATH`, etc.).
Diagnostics: `claude doctor`.

## Minimum requirements

macOS 13.0+ · Ubuntu 20.04+/Debian 10+ · Alpine 3.19+ (with `libgcc libstdc++` + ripgrep) ·
Windows 10 1809+ (or WSL) · 4 GB RAM · x64 or ARM64.

## References

- Setup: <https://code.claude.com/docs/en/setup>
- Troubleshoot: <https://code.claude.com/docs/en/troubleshoot-install>
- CLI reference: <https://code.claude.com/docs/en/cli-reference>
