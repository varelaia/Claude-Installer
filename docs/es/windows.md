---
title: "Instalar Claude Code en Windows"
description: "Cómo instalar Claude Code (el CLI de Anthropic) en Windows nativo (PowerShell/CMD) o WSL, configurar el PATH y verificar."
---

# Instalar Claude Code en Windows

Funciona en **Windows nativo** (10 1809+ / Server 2019+, x64 o ARM64) o dentro de **WSL**.
No requiere permisos de administrador.

## Opción A — Instalador oficial nativo

=== "PowerShell"

    ```powershell
    irm https://claude.ai/install.ps1 | iex
    ```

=== "CMD"

    ```bat
    curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
    ```

El binario se instala en `%USERPROFILE%\.local\bin\claude.exe` y se añade al PATH de usuario.

!!! tip "¿PowerShell o CMD?"
    Si el prompt empieza con `PS C:\…>` estás en **PowerShell**; si es `C:\…>` estás en
    **CMD**. Usa el comando de la pestaña correcta.

## Opción B — Script de este repo (PowerShell, sin admin)

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.ps1 | iex
```

Delega en el instalador oficial y asegura el PATH de usuario. Al terminar, **cierra y vuelve
a abrir** PowerShell.

## Opción C — WinGet

```powershell
winget install Anthropic.ClaudeCode
```

Actualización manual: `winget upgrade Anthropic.ClaudeCode`.

## Git para Windows (recomendado)

Sin Git para Windows, Claude Code usa **PowerShell** para los comandos de shell. Con **Git
para Windows** instalado, usa **Git Bash** (preferido). Si no lo detecta, apúntalo en
`settings.json`:

```json
{ "CLAUDE_CODE_GIT_BASH_PATH": "C:\\Program Files\\Git\\bin\\bash.exe" }
```

## WSL (para toolchains Linux)

Si trabajas con herramientas Linux, instala Claude Code **dentro de la terminal de WSL**
(no desde PowerShell/CMD), siguiendo la guía de [Linux](linux.md). **WSL 2** habilita
sandboxing; **WSL 1** también funciona (sin sandboxing).

## Verificar

```powershell
claude --version   # versión instalada
claude doctor      # diagnóstico completo
```

Después, entra a la carpeta de un proyecto y ejecuta `claude`. La primera vez se abrirá el
navegador para iniciar sesión.

¿Algo falla? Revisa la [Solución de problemas](troubleshooting.md).
