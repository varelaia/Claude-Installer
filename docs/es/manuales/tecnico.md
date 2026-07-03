---
title: "Manual técnico — Claude Code"
description: "Arquitectura de la instalación de Claude Code: binario nativo, ubicación, PATH, auto-update, canales de versión, autenticación y configuración."
---

# Manual técnico

## Qué es

**Claude Code** es un CLI agéntico de Anthropic. El instalador nativo entrega **un binario
autocontenido** — no es un paquete Node interpretado; el `claude` instalado **no invoca
Node.js** en tiempo de ejecución.

## Métodos de instalación y qué entregan

| Método | Qué baja | Node requerido |
|---|---|---|
| Instalador nativo (`install.sh`/`.ps1`/`.cmd`) | binario nativo | no |
| npm (`@anthropic-ai/claude-code`) | el **mismo** binario nativo vía dependencias opcionales por plataforma (`…-darwin-arm64`, `…-linux-x64`, …) | sí, 18+ (solo para instalar) |
| Homebrew cask (`claude-code`) | binario ya compilado (cask, no formula) | no |
| WinGet (`Anthropic.ClaudeCode`) | binario nativo | no |

## Ubicación y PATH

- **Binario:** `~/.local/bin/claude` (symlink) → `~/.local/share/claude/versions/<versión>`.
  En Windows: `%USERPROFILE%\.local\bin\claude.exe`.
- **Datos/versiones:** `~/.local/share/claude/` (Windows: `%USERPROFILE%\.local\share\claude\`).
- El instalador nativo añade `~/.local/bin` al `PATH` automáticamente. Si el shell no lo
  recoge, se persiste a mano en el perfil (`~/.zshrc`/`~/.bashrc`/PATH de usuario).

## Auto-update y canales

- El instalador nativo **auto-actualiza** en segundo plano (comprueba al arrancar).
- Canales: `latest` (por defecto) y `stable` (~1 semana atrás, evita regresiones). Se cambia
  con `/config` → "Auto-update channel" o en `settings.json`:
  ```json
  { "autoUpdatesChannel": "stable" }
  ```
- Cada actualización deja la versión anterior en `versions/` (limpieza: `claude_cleanup.sh`).
- Homebrew/WinGet/npm **no** auto-actualizan (update manual).

## Autenticación

`claude` abre el navegador para OAuth con la cuenta (Pro/Max/Team/Enterprise o Console API).
Las credenciales quedan guardadas localmente (login persistente). Proveedores enterprise:
Amazon Bedrock, Google Vertex AI, Microsoft Foundry.

## Configuración

`settings.json` controla comportamiento (canal de update, ripgrep en Alpine con
`"USE_BUILTIN_RIPGREP": 0`, ruta de Git Bash en Windows con `CLAUDE_CODE_GIT_BASH_PATH`, etc.).
Diagnóstico: `claude doctor`.

## Requisitos mínimos

macOS 13.0+ · Ubuntu 20.04+/Debian 10+ · Alpine 3.19+ (con `libgcc libstdc++` + ripgrep) ·
Windows 10 1809+ (o WSL) · 4 GB RAM · x64 o ARM64.

## Referencias

- Setup: <https://code.claude.com/docs/en/setup>
- Troubleshoot: <https://code.claude.com/docs/en/troubleshoot-install>
- CLI reference: <https://code.claude.com/docs/en/cli-reference>
