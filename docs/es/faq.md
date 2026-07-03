---
title: "Preguntas frecuentes — Claude Code"
description: "Dudas comunes al instalar y usar Claude Code: Node.js, tamaño, autenticación, plan gratuito, actualizaciones y desinstalación."
---

# Preguntas frecuentes

## ¿Necesito Node.js?

**No**, si usas el **instalador nativo** (recomendado) o Homebrew/WinGet: bajan un binario
autocontenido. **Sí**, solo si instalas por `npm` (Node 18+).

## ¿Cuánto pesa la instalación?

El binario de Claude Code es **un solo archivo (~238 MB)** — no arrastra árboles de
dependencias ni herramientas de build. Con el tiempo, el auto-update puede acumular versiones
viejas en `~/.local/share/claude/versions/`; libéralas con el script
[`claude_cleanup.sh`](https://github.com/varelaia/Claude-Installer/blob/main/scripts/claude_cleanup.sh).

## ¿Sirve con el plan gratuito de Claude.ai?

No. Claude Code requiere suscripción **Pro, Max, Team o Enterprise**, o una cuenta de
**Console** con acceso a la API (o un proveedor enterprise: Bedrock/Vertex/Foundry).

## ¿Cómo inicio sesión?

Ejecuta `claude` en cualquier proyecto: se abre el navegador para autenticarte. Dentro de una
sesión puedes reautenticarte con `/login`.

## ¿Cómo se actualiza?

- **Instalador nativo:** se auto-actualiza en segundo plano (canal `latest` por defecto;
  puedes cambiar a `stable`).
- **Homebrew:** manual → `brew upgrade claude-code`.
- **npm:** manual → `npm install -g @anthropic-ai/claude-code@latest` (no uses `npm update -g`).
- **WinGet:** manual → `winget upgrade Anthropic.ClaudeCode`.

## ¿Cómo verifico que quedó bien?

```bash
claude --version
claude doctor
```

## ¿Cómo lo desinstalo?

Borra el binario y sus datos:

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
```

En Windows: borra `%USERPROFILE%\.local\bin\claude.exe` y `%USERPROFILE%\.local\share\claude`.
Si instalaste por Homebrew/npm/WinGet, desinstala por ese gestor.

## ¿Qué diferencia hay entre este repo y los comandos oficiales?

Ninguna en el binario: usamos el **instalador oficial** de Anthropic. Este repo solo añade
scripts que **aseguran el PATH**, verifican el resultado y documentan requisitos y problemas
comunes en un solo lugar.
