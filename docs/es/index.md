---
title: "Instalar Claude Code — guía paso a paso (Linux, macOS, Windows)"
description: "Cómo instalar Claude Code (el CLI de Anthropic) en Linux, macOS y Windows con el instalador nativo. Requisitos, PATH, autenticación y solución de problemas."
---

# Cómo instalar Claude Code

**Claude Code** es la herramienta de línea de comandos (CLI) de **Anthropic** para programar
con Claude directamente en tu terminal: lee y edita tu código, ejecuta comandos y trabaja
sobre tu proyecto de forma agéntica.

Esta guía explica cómo instalarlo **de forma simple y verificable** en **Linux**, **macOS**
y **Windows**, sin permisos de administrador.

!!! tip "En una frase"
    Claude Code se instala con **un solo comando**. El instalador nativo baja **un binario
    autocontenido** a `~/.local/bin` — **no necesita Node.js** — y se auto-actualiza solo.

## Instalación rápida (instalador nativo — recomendado)

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

Después, abre una terminal **nueva** y comprueba:

```bash
claude --version
```

Para empezar, entra a la carpeta de tu proyecto y ejecuta `claude`. La primera vez se abrirá
el navegador para **iniciar sesión** (ver [Autenticación](#autenticacion)).

## ¿Qué necesito antes de empezar?

| Sistema | Requisito |
|---|---|
| **Linux** | Ubuntu 20.04+/Debian 10+ (o equivalente), 4 GB RAM, x64 o ARM64 |
| **macOS** | **macOS 13.0 (Ventura) o superior**, 4 GB RAM |
| **Windows** | Windows 10 1809+ (nativo) o **WSL 2** para toolchains Linux |
| **Node.js** | **Solo** si instalas por `npm` (Node 18+). El instalador nativo **no** lo necesita. |

## Otras formas de instalar

| Método | Comando | Nota |
|---|---|---|
| **npm** | `npm install -g @anthropic-ai/claude-code` | requiere Node 18+; instala el mismo binario |
| **Homebrew** | `brew install --cask claude-code` | macOS/Linux; update manual (`brew upgrade`) |
| **WinGet** | `winget install Anthropic.ClaudeCode` | Windows |

Detalle por sistema: [Linux](linux.md) · [macOS](macos.md) · [Windows](windows.md).

## Autenticación

Al ejecutar `claude` por primera vez se abre el navegador para iniciar sesión. Funciona con:

- Suscripción **Claude Pro, Max, Team o Enterprise** (recomendado).
- Cuenta **Claude Console** con acceso a la API.
- Proveedores enterprise: **Amazon Bedrock, Google Vertex AI, Microsoft Foundry**.

!!! warning "El plan gratuito NO incluye Claude Code"
    Necesitas una suscripción de pago (Pro/Max/Team/Enterprise) o una cuenta de Console con API.

Para reautenticarte dentro de una sesión: escribe `/login`.

## Verificar y diagnosticar

```bash
claude --version   # versión instalada
claude doctor      # diagnóstico de instalación, configuración y actualizaciones
```

## Scripts de este repo

Además de los comandos oficiales, este repositorio incluye wrappers ligeros que persisten el
PATH y verifican el resultado — ver el [README](https://github.com/varelaia/Claude-Installer).
La instalación es **mínima por diseño**: solo el binario `claude`, sin suites de herramientas.

¿Algo falla? Revisa la [Solución de problemas](troubleshooting.md).
