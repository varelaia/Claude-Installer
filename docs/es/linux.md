---
title: Instalar Claude Code en Linux
description: Cómo instalar Claude Code (el CLI de Anthropic) en Linux (Ubuntu, Debian, Alpine), configurar el PATH y verificar la instalación.
---

# Instalar Claude Code en Linux

Funciona en **x86_64** y **ARM64**. No requiere permisos de administrador: el instalador
nativo baja un binario autocontenido a `~/.local/bin/claude`.

## Requisitos

- Ubuntu **20.04+**, Debian **10+** (o distribución equivalente).
- 4 GB de RAM.
- `curl` o `wget`.
- **Alpine Linux 3.19+**: instala `libgcc libstdc++` y `ripgrep`, y añade
  `"USE_BUILTIN_RIPGREP": 0` en `settings.json`.

## Opción A — Instalador oficial (1 comando)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

El instalador descarga el binario a `~/.local/bin/claude`, lo añade al PATH y se
auto-actualiza en segundo plano. **No necesita Node.js.**

## Opción B — Script de este repo (instala + asegura el PATH)

```bash
git clone https://github.com/varelaia/Claude-Installer.git
cd Claude-Installer
chmod +x scripts/install_claude.sh
./scripts/install_claude.sh
```

O directo, sin clonar:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

## Opción C — npm (si ya usas Node)

```bash
npm install -g @anthropic-ai/claude-code
```

Requiere **Node.js 18+**. Instala el mismo binario nativo. **No uses `sudo npm install -g`**
(causa problemas de permisos); si `npm` global no es escribible, configura un prefijo de
usuario: `mkdir ~/.npm-global && npm config set prefix ~/.npm-global`.

## Configurar el PATH

Si tras instalar `claude` "no se encuentra", añade `~/.local/bin` al PATH de tu shell y
recarga:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc   # o ~/.zshrc
source ~/.bashrc                                            # o ~/.zshrc
```

## Verificar

```bash
claude --version   # versión instalada
claude doctor      # diagnóstico completo
```

Después, entra a la carpeta de un proyecto y ejecuta `claude`. La primera vez se abrirá el
navegador para iniciar sesión.

¿Algo falla? Revisa la [Solución de problemas](troubleshooting.md).
