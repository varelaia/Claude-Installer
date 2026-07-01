---
title: Manual operativo — Claude Code
description: Procedimientos de operación de Claude Code: instalar, verificar, actualizar, limpiar versiones viejas, revertir y desinstalar.
---

# Manual operativo

Procedimientos paso a paso para instalar y mantener Claude Code de forma controlada.

## Instalar

```bash
# Instalador nativo (recomendado)
curl -fsSL https://claude.ai/install.sh | bash          # Linux / macOS
# o el wrapper del repo (verifica macOS 13 + PATH):
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

Windows: `irm https://claude.ai/install.ps1 | iex` (PowerShell).

## Verificar (obligatorio antes de dar por bueno)

```bash
claude --version    # imprime versión → binario en PATH
claude doctor       # estado de instalación, config y último update
```

Prueba real: entra a un proyecto, ejecuta `claude`, completa el login y confirma que responde.

## Actualizar

- **Nativo:** automático. Forzar comprobación: reabrir `claude` o `claude doctor`.
- **Homebrew:** `brew upgrade claude-code` (o `claude-code@latest`).
- **npm:** `npm install -g @anthropic-ai/claude-code@latest`.
- **WinGet:** `winget upgrade Anthropic.ClaudeCode`.

## Limpiar versiones viejas (liberar disco)

El auto-update acumula binarios anteriores (~238 MB c/u) en `~/.local/share/claude/versions/`.

```bash
./scripts/claude_cleanup.sh           # dry-run: muestra qué borraría
./scripts/claude_cleanup.sh --apply   # borra las viejas, conserva la activa
```

## Revertir / reinstalar limpio

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
curl -fsSL https://claude.ai/install.sh | bash
```

## Desinstalar

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
```

Windows: borra `%USERPROFILE%\.local\bin\claude.exe` y `%USERPROFILE%\.local\share\claude`.
Si instalaste por gestor (brew/npm/winget), desinstala por ese gestor.

## Checklist de despliegue en un equipo nuevo

1. Verificar requisitos (SO/versión, 4 GB RAM). En macOS: `sw_vers` ≥ 13.0.
2. Instalar (nativo).
3. `claude --version` → 2xx lógico (imprime versión).
4. `claude doctor` sin errores.
5. `claude` + login real en un proyecto de prueba.
