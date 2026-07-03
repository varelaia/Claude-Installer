---
title: "User manual — Claude Code"
description: "A simple guide to get started with Claude Code: install, sign in, first steps and basic commands."
---

# User manual

A simple, jargon-free guide to install and start using **Claude Code**.

## 1. Install (one command)

Open your terminal and paste the command for your system:

- **Mac / Linux:** `curl -fsSL https://claude.ai/install.sh | bash`
- **Windows (PowerShell):** `irm https://claude.ai/install.ps1 | iex`

When it finishes, **close and open a new terminal**.

## 2. Check that it installed

```bash
claude --version
```

It should print a version number. If it says "command not found", open a new terminal or check
[Troubleshooting](../troubleshooting.md).

## 3. Sign in

Go to your project folder and type:

```bash
claude
```

The first time, the **browser** opens to sign in with your Claude account (**Pro, Max, Team or
Enterprise** — the free plan doesn't include Claude Code). Accept and you're done.

## 4. Using it

Once inside, Claude Code works like a chat in your terminal that can also **read and edit your
code** and **run commands** in your project. Type what you need in plain language, for example:

- *"Explain what this project does."*
- *"Fix the bug in the login function."*
- *"Add tests to this file."*

Useful commands within the session:

- `/login` — sign in again.
- `/help` — see the help.
- To **exit**: `Ctrl + C` or type `/exit`.

## 5. If something doesn't work

- Open a **new** terminal and try `claude --version` again.
- On Mac, verify you have **macOS 13 or later** (`sw_vers`).
- Check [Troubleshooting](../troubleshooting.md).
