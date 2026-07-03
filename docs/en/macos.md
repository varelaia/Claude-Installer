---
title: "Install Claude Code on macOS"
description: "How to install Claude Code (Anthropic's CLI) on macOS (Intel and Apple Silicon), the macOS 13+ requirement, and configuring zsh and the PATH."
---

# Install Claude Code on macOS

Works on **Intel (x86_64)** and **Apple Silicon (arm64)**. No administrator privileges
required. The default shell on modern macOS is **zsh**.

!!! danger "Requirement: macOS 13.0 (Ventura) or later — check this FIRST"
    Claude Code requires **macOS 13.0+**. Before installing, check your version:

    ```bash
    sw_vers
    ```

    If `ProductVersion` is **below 13.0** → update macOS (System Settings → Software Update)
    or use a newer Mac.

## Option A — Official installer (1 command)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Downloads the binary to `~/.local/bin/claude`, adds it to the PATH and auto-updates in the
background. **No Node.js required.**

## Option B — Script from this repo (installs + verifies macOS 13 + PATH)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

The script checks that you're on macOS 13+, runs the official installer and persists
`~/.local/bin` in your `~/.zshrc`.

## Option C — Homebrew

```bash
brew install --cask claude-code           # stable channel
brew install --cask claude-code@latest    # latest channel (immediate updates)
```

It's a **cask** (downloads the pre-compiled binary) — it does **not** pull in build tools.
Homebrew does **not** auto-update: use `brew upgrade claude-code` whenever you want to update.

## Configure the PATH (zsh)

If `claude` is "not found" after installing:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

!!! warning "If your terminal uses bash instead of zsh"
    Some Macs (or Terminal configured by hand) open **bash**, which **does not read
    `~/.zshrc`**. If your prompt ends in `$` (not `%`), use `~/.bash_profile` instead of
    `~/.zshrc`.

## Verify

```bash
claude --version   # installed version
claude doctor      # full diagnostic
```

Then go to a project folder and run `claude`. The first time, the browser will open to sign
in.

Something failing? Check **[Troubleshooting](troubleshooting.md)**.
