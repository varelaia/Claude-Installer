---
title: "Operations manual — Claude Code"
description: "Claude Code operating procedures: install, verify, update, clean up old versions, roll back and uninstall."
---

# Operations manual

Step-by-step procedures to install and maintain Claude Code in a controlled way.

## Install

```bash
# Native installer (recommended)
curl -fsSL https://claude.ai/install.sh | bash          # Linux / macOS
# or the repo wrapper (verifies macOS 13 + PATH):
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

Windows: `irm https://claude.ai/install.ps1 | iex` (PowerShell).

## Verify (mandatory before signing off)

```bash
claude --version    # prints version → binary on PATH
claude doctor       # installation, config and last-update status
```

Real test: go into a project, run `claude`, complete the login and confirm it responds.

## Update

- **Native:** automatic. Force a check: reopen `claude` or run `claude doctor`.
- **Homebrew:** `brew upgrade claude-code` (or `claude-code@latest`).
- **npm:** `npm install -g @anthropic-ai/claude-code@latest`.
- **WinGet:** `winget upgrade Anthropic.ClaudeCode`.

## Clean up old versions (free disk space)

The auto-update accumulates previous binaries (~238 MB each) in
`~/.local/share/claude/versions/`.

```bash
./scripts/claude_cleanup.sh           # dry-run: shows what it would delete
./scripts/claude_cleanup.sh --apply   # deletes the old ones, keeps the active one
```

## Roll back / clean reinstall

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
curl -fsSL https://claude.ai/install.sh | bash
```

## Uninstall

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
```

Windows: delete `%USERPROFILE%\.local\bin\claude.exe` and `%USERPROFILE%\.local\share\claude`.
If you installed via a manager (brew/npm/winget), uninstall through that manager.

## Deployment checklist for a new machine

1. Verify requirements (OS/version, 4 GB RAM). On macOS: `sw_vers` ≥ 13.0.
2. Install (native).
3. `claude --version` → logical 2xx (prints version).
4. `claude doctor` with no errors.
5. `claude` + real login in a test project.
