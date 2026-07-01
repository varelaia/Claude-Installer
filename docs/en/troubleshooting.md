---
title: Claude Code troubleshooting
description: Common errors when installing Claude Code and how to resolve them: command not found, PATH, npm permissions, macOS 13, Windows execution policy, WSL, login.
---

# Troubleshooting

## `claude: command not found` / `claude not recognized`

The binary was installed but it's not on your `PATH`, or the terminal hasn't reloaded the
profile yet.

=== "Linux / macOS"

    ```bash
    # 1) Confirm the binary exists:
    ls -l ~/.local/bin/claude
    # 2) Add to PATH and reload:
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc   # or ~/.zshrc
    source ~/.bashrc                                            # or ~/.zshrc
    ```

=== "Windows"

    Open a **new** terminal (the PATH doesn't update in the current session). If it's still not
    recognized, check that `%USERPROFILE%\.local\bin` is on the user PATH.

!!! info "Why it happens"
    A script cannot change the `PATH` of the terminal that invoked it. You always need a **new
    terminal** or `source` after installing.

!!! warning "macOS: if you use zsh, it goes in `~/.zshrc` (not `~/.bashrc`)"
    Modern macOS uses **zsh**, which **does not read `~/.bashrc`**. If the installer wrote the
    PATH to `~/.bashrc`, put it in `~/.zshrc`. And if your prompt ends in `$` (bash, not zsh),
    use `~/.bash_profile`.

## `claude --version` prints nothing / stays the same

Almost always it's PATH: you're invoking a `claude` that doesn't exist in this session. Try
with the absolute path:

```bash
~/.local/bin/claude --version
```

If it does print with the absolute path, it's PATH (see above).

## macOS: requires macOS 13.0 (Ventura) or later

Claude Code doesn't support earlier versions of macOS. Check with `sw_vers`; if
`ProductVersion` is below 13.0, update macOS or use a newer Mac.

## npm: `EACCES: permission denied`

The global npm directory isn't writable. **Don't use `sudo`** (it causes permission and
security problems). Configure a user prefix:

```bash
mkdir ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc   # or ~/.zshrc
```

Better yet: use the **native installer**, which doesn't depend on npm.

## `curl: (403)` or `syntax error near unexpected token '<'`

Usually a proxy/firewall returning HTML instead of the script. Check your network/proxy and
retry; if it persists, try another method (npm, Homebrew) or check the official
[installation troubleshooting guide](https://code.claude.com/docs/en/troubleshoot-install).

## Windows: the PowerShell script won't run (execution policy)

Run in the same console, without admin:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```

and launch the command again. Make sure you're in **PowerShell** (not CMD).

## Can't sign in / "not included in your plan"

Claude Code does **not** work with the free Claude.ai plan. You need **Pro, Max, Team or
Enterprise**, or a **Console** account with API. Within a session, re-authenticate with
`/login`.

## The Claude folder grew a lot (hundreds of MB)

The auto-update keeps old versions in `~/.local/share/claude/versions/`. Free them up by
leaving only the active one:

```bash
# dry-run (shows what it would delete):
./scripts/claude_cleanup.sh
# actually delete:
./scripts/claude_cleanup.sh --apply
```

## `claude` still appears after uninstalling

There's a conflicting installation (several copies or an alias). Find them:

```bash
which -a claude
```

and remove the leftover copy or the alias in your shell profile.

---

Your case isn't here? Open an *issue* on
[GitHub](https://github.com/varelaia/Claude-Installer/issues) or check the
[official documentation](https://code.claude.com/docs/en/troubleshoot-install).
