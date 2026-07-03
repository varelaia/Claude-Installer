---
title: "Install Claude Code on Windows"
description: "How to install Claude Code (Anthropic's CLI) on native Windows (PowerShell/CMD) or WSL, configure the PATH and verify."
---

# Install Claude Code on Windows

Works on **native Windows** (10 1809+ / Server 2019+, x64 or ARM64) or inside **WSL**.
No administrator privileges required.

## Option A — Official native installer

=== "PowerShell"

    ```powershell
    irm https://claude.ai/install.ps1 | iex
    ```

=== "CMD"

    ```bat
    curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
    ```

The binary is installed at `%USERPROFILE%\.local\bin\claude.exe` and added to the user PATH.

!!! tip "PowerShell or CMD?"
    If the prompt starts with `PS C:\…>` you're in **PowerShell**; if it's `C:\…>` you're in
    **CMD**. Use the command from the correct tab.

## Option B — Script from this repo (PowerShell, no admin)

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.ps1 | iex
```

It delegates to the official installer and ensures the user PATH. When it finishes, **close
and reopen** PowerShell.

## Option C — WinGet

```powershell
winget install Anthropic.ClaudeCode
```

Manual update: `winget upgrade Anthropic.ClaudeCode`.

## Git for Windows (recommended)

Without Git for Windows, Claude Code uses **PowerShell** for shell commands. With **Git for
Windows** installed, it uses **Git Bash** (preferred). If it doesn't detect it, point to it in
`settings.json`:

```json
{ "CLAUDE_CODE_GIT_BASH_PATH": "C:\\Program Files\\Git\\bin\\bash.exe" }
```

## WSL (for Linux toolchains)

If you work with Linux tools, install Claude Code **inside the WSL terminal** (not from
PowerShell/CMD), following the [Linux](linux.md) guide. **WSL 2** enables sandboxing; **WSL 1**
also works (without sandboxing).

## Verify

```powershell
claude --version   # installed version
claude doctor      # full diagnostic
```

Then go to a project folder and run `claude`. The first time, the browser will open to sign
in.

Something failing? Check **[Troubleshooting](troubleshooting.md)**.
