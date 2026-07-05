---
title: "Install Claude Code — step-by-step guide (Linux, macOS, Windows)"
description: "How to install Claude Code (Anthropic's CLI) on Linux, macOS and Windows with the native installer. Requirements, PATH, authentication and troubleshooting."
---

# How to install Claude Code

**Claude Code** is **Anthropic's** command-line tool (CLI) for coding with Claude directly in
your terminal: it reads and edits your code, runs commands and works on your project
agentically.

This guide explains how to install it **simply and verifiably** on **Linux**, **macOS** and
**Windows**, without administrator privileges.

!!! tip "In one sentence"
    Claude Code installs with **a single command**. The native installer downloads **a
    self-contained binary** to `~/.local/bin` — **no Node.js required** — and updates itself
    automatically.

## Quick install (native installer — recommended)

=== "Linux / macOS"

    ```bash
    curl -fsSL https://claude.ai/install.sh | bash
    ```

=== "Windows (PowerShell)"

    ```powershell
    irm https://claude.ai/install.ps1 | iex
    ```

=== "Windows (CMD)"

    ```bat
    curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
    ```

Then open a **new** terminal and check:

```bash
claude --version
```

To get started, go to your project folder and run `claude`. The first time, the browser will
open to **sign in** (see [Authentication](#authentication)).

## What do I need before starting?

| System | Requirement |
|---|---|
| **Linux** | Ubuntu 20.04+/Debian 10+ (or equivalent), 4 GB RAM, x64 or ARM64 |
| **macOS** | **macOS 13.0 (Ventura) or later**, 4 GB RAM |
| **Windows** | Windows 10 1809+ (native) or **WSL 2** for Linux toolchains |
| **Node.js** | **Only** if you install via `npm` (Node 18+). The native installer does **not** need it. |

## Other ways to install

| Method | Command | Note |
|---|---|---|
| **npm** | `npm install -g @anthropic-ai/claude-code` | requires Node 18+; installs the same binary |
| **Homebrew** | `brew install --cask claude-code` | macOS/Linux; manual update (`brew upgrade`) |
| **WinGet** | `winget install Anthropic.ClaudeCode` | Windows |

Details per system: [Linux](linux.md) · [macOS](macos.md) · [Windows](windows.md).

## Authentication

The first time you run `claude`, the browser opens to sign in. It works with:

- A **Claude Pro, Max, Team or Enterprise** subscription (recommended).
- A **Claude Console** account with API access.
- Enterprise providers: **Amazon Bedrock, Google Vertex AI, Microsoft Foundry**.

!!! warning "The free plan does NOT include Claude Code"
    You need a paid subscription (Pro/Max/Team/Enterprise) or a Console account with API.

To re-authenticate within a session: type `/login`.

## Verify and diagnose

```bash
claude --version   # installed version
claude doctor      # diagnostic of installation, configuration and updates
```

## Scripts in this repo

Besides the official commands, this repository includes lightweight wrappers that persist the
PATH and verify the result — see the [README](https://github.com/varelaia/Claude-Installer).
The installation is **minimal by design**: only the `claude` binary, no tool suites.

Something failing? Check **[Troubleshooting](troubleshooting.md)**.


<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "Claude-Installer",
  "applicationCategory": "DeveloperApplication",
  "operatingSystem": "Linux, macOS, Windows",
  "description": "Step-by-step guide and scripts to install Claude Code (Anthropic's CLI) on Linux, macOS and Windows without administrator rights.",
  "inLanguage": "en",
  "url": "https://varelaia.github.io/Claude-Installer/",
  "sameAs": "https://github.com/varelaia/Claude-Installer",
  "license": "https://opensource.org/licenses/MIT",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "USD"
  },
  "author": {
    "@type": "Organization",
    "name": "Varela Insights",
    "url": "https://www.varelainsights.com/",
    "founder": {
      "@type": "Person",
      "name": "Irving Varela"
    }
  }
}
</script>
