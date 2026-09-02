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

## Native or WSL? How to choose

| Option | Requires | [Sandboxing](https://code.claude.com/docs/en/sandboxing) | When to use it |
|---|---|---|---|
| **Native Windows** | Nothing (Git for Windows optional) | Not supported | Windows-native projects and tools |
| **WSL 2** | WSL 2 enabled | Supported | Linux toolchains or sandboxed command execution |
| **WSL 1** | WSL 1 enabled | Not supported | If WSL 2 isn't available on your machine |

## Install WSL2 + Ubuntu (if you don't have it yet)

Requires **Windows 10 version 2004 (build 19041) or later, or Windows 11**. If what you want is
"the Ubuntu terminal on Windows," this is the step before Claude Code — install WSL first,
then Claude Code inside that terminal.

1. Open **PowerShell as Administrator** (right-click → "Run as administrator").
2. Run:

   ```powershell
   wsl --install
   ```

   This enables the required Windows features and installs **Ubuntu** as the default
   distribution on **WSL 2**. To install a different distro instead:
   `wsl --install -d <Distro>` (list available ones with `wsl --list --online`).
3. **Restart the computer** when prompted.
4. On restart, an Ubuntu console opens automatically. Wait for it to decompress files, then
   **create your Linux username and password** (independent from your Windows account).
5. Confirm it landed on **WSL 2**:

   ```powershell
   wsl -l -v
   ```

   The `VERSION` column should read `2`. If it says `1`, convert it:
   `wsl --set-version Ubuntu 2`.

With Ubuntu installed, open it from the Start menu (or `wsl` from PowerShell) and follow the
section below to install Claude Code **inside** that terminal.

!!! tip "Windows Terminal"
    Use [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) to open Ubuntu in
    tabs, with configurable profiles and shortcuts — the recommended way to work with WSL.

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
