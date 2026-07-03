---
title: "Install Claude Code on Linux"
description: "How to install Claude Code (Anthropic's CLI) on Linux (Ubuntu, Debian, Alpine), configure the PATH and verify the installation."
---

# Install Claude Code on Linux

Works on **x86_64** and **ARM64**. No administrator privileges required: the native installer
downloads a self-contained binary to `~/.local/bin/claude`.

## Requirements

- Ubuntu **20.04+**, Debian **10+** (or an equivalent distribution).
- 4 GB of RAM.
- `curl` or `wget`.
- **Alpine Linux 3.19+**: install `libgcc libstdc++` and `ripgrep`, and add
  `"USE_BUILTIN_RIPGREP": 0` to `settings.json`.

## Option A — Official installer (1 command)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

The installer downloads the binary to `~/.local/bin/claude`, adds it to the PATH and
auto-updates in the background. **No Node.js required.**

## Option B — Script from this repo (installs + ensures the PATH)

```bash
git clone https://github.com/varelaia/Claude-Installer.git
cd Claude-Installer
chmod +x scripts/install_claude.sh
./scripts/install_claude.sh
```

Or directly, without cloning:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

## Option C — npm (if you already use Node)

```bash
npm install -g @anthropic-ai/claude-code
```

Requires **Node.js 18+**. Installs the same native binary. **Don't use `sudo npm install -g`**
(it causes permission problems); if the global `npm` isn't writable, configure a user prefix:
`mkdir ~/.npm-global && npm config set prefix ~/.npm-global`.

## Configure the PATH

If `claude` is "not found" after installing, add `~/.local/bin` to your shell's PATH and
reload:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc   # or ~/.zshrc
source ~/.bashrc                                            # or ~/.zshrc
```

## Verify

```bash
claude --version   # installed version
claude doctor      # full diagnostic
```

Then go to a project folder and run `claude`. The first time, the browser will open to sign
in.

Something failing? Check **[Troubleshooting](troubleshooting.md)**.
