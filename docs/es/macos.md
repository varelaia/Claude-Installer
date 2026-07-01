---
title: Instalar Claude Code en macOS
description: Cómo instalar Claude Code (el CLI de Anthropic) en macOS (Intel y Apple Silicon), requisito macOS 13+, configurar zsh y el PATH.
---

# Instalar Claude Code en macOS

Funciona en **Intel (x86_64)** y **Apple Silicon (arm64)**. No requiere permisos de
administrador. El shell por defecto en macOS moderno es **zsh**.

!!! danger "Requisito: macOS 13.0 (Ventura) o superior — verifícalo PRIMERO"
    Claude Code requiere **macOS 13.0+**. Antes de instalar, comprueba tu versión:

    ```bash
    sw_vers
    ```

    Si `ProductVersion` es **menor a 13.0** → actualiza macOS (Ajustes → Actualización de
    software) o usa un Mac más nuevo.

## Opción A — Instalador oficial (1 comando)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Descarga el binario a `~/.local/bin/claude`, lo añade al PATH y se auto-actualiza en segundo
plano. **No necesita Node.js.**

## Opción B — Script de este repo (instala + verifica macOS 13 + PATH)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

El script comprueba que estés en macOS 13+, ejecuta el instalador oficial y persiste
`~/.local/bin` en tu `~/.zshrc`.

## Opción C — Homebrew

```bash
brew install --cask claude-code           # canal estable
brew install --cask claude-code@latest    # canal latest (actualizaciones inmediatas)
```

Es un **cask** (descarga el binario ya compilado) — **no** arrastra herramientas de build.
Homebrew **no** auto-actualiza: usa `brew upgrade claude-code` cuando quieras actualizar.

## Configurar el PATH (zsh)

Si `claude` "no se encuentra" tras instalar:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

!!! warning "Si tu terminal usa bash en vez de zsh"
    Algunos Macs (o Terminal configurada a mano) abren **bash**, que **no lee `~/.zshrc`**.
    Si tu prompt termina en `$` (no en `%`), usa `~/.bash_profile` en lugar de `~/.zshrc`.

## Verificar

```bash
claude --version   # versión instalada
claude doctor      # diagnóstico completo
```

Después, entra a la carpeta de un proyecto y ejecuta `claude`. La primera vez se abrirá el
navegador para iniciar sesión.

¿Algo falla? Revisa la [Solución de problemas](troubleshooting.md).
