# Claude Code — Instalador y Guía Completa

> **📖 Documentación completa (sitio): https://varelaia.github.io/Claude-Installer/**

Guía paso a paso, scripts y manuales para instalar **Claude Code** — el CLI de **Anthropic**
para programar con Claude en tu terminal — en **Linux**, **macOS** y **Windows**, sin permisos
de administrador.

El instalador nativo baja **un binario autocontenido** (~238 MB) a `~/.local/bin`, **no usa
Node.js** y se auto-actualiza. Instalación **mínima por diseño**: solo el binario `claude`,
sin suites de herramientas.

---

## ⚡ Instalación rápida (instalador nativo — recomendado)

**Linux / macOS**

```
curl -fsSL https://claude.ai/install.sh | bash
```

**Windows (PowerShell)**

```
irm https://claude.ai/install.ps1 | iex
```

**Windows (CMD)**

```
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

Tras instalar, abre una terminal nueva y verifica:

```
claude --version
```

Para empezar, entra a tu proyecto y ejecuta `claude` (la primera vez se abre el navegador para
iniciar sesión).

> [!IMPORTANT]
> **macOS requiere macOS 13.0 (Ventura) o superior.** Verifícalo con `sw_vers`. Los scripts de
> este repo abortan solo si detectan una versión menor.

> [!NOTE]
> **El plan gratuito de Claude.ai NO incluye Claude Code.** Necesitas suscripción **Pro, Max,
> Team o Enterprise**, o una cuenta de **Console** con acceso a la API.

---

## 📦 Requisitos

| Sistema | Requisito |
|---|---|
| **Linux** | Ubuntu 20.04+/Debian 10+, 4 GB RAM, x64 o ARM64 |
| **macOS** | **macOS 13.0 (Ventura)+**, 4 GB RAM |
| **Windows** | Windows 10 1809+ (nativo) o WSL 2 |
| **Node.js** | **Solo** para el método `npm` (Node 18+). El instalador nativo no lo necesita. |

---

## 🔀 Otras formas de instalar

```
npm install -g @anthropic-ai/claude-code     # requiere Node 18+ (instala el mismo binario)
brew install --cask claude-code              # macOS/Linux (update manual: brew upgrade)
winget install Anthropic.ClaudeCode          # Windows
```

⚠️ **No uses `sudo npm install -g`** (problemas de permisos). Si npm global no es escribible:
`mkdir ~/.npm-global && npm config set prefix ~/.npm-global`.

---

## 🛠️ Scripts de este repo

| Script | Plataforma | Qué hace |
|---|---|---|
| `scripts/install_claude.sh` | Linux / macOS | Ejecuta el instalador oficial + verifica **macOS 13+** + persiste `~/.local/bin` en el PATH + verifica |
| `scripts/install_claude.ps1` | Windows | Ejecuta el instalador oficial + persiste el PATH de usuario + verifica |
| `scripts/claude_cleanup.sh` | Linux / macOS | **Anti-bloat**: borra versiones viejas acumuladas por el auto-update (`~/.local/share/claude/versions/`), conserva la activa. Dry-run por defecto; `--apply` para borrar |

One-liners (sin clonar):

```
# Linux / macOS
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.sh)"
```

```
# Windows (PowerShell, sin admin)
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/varelaia/Claude-Installer/main/scripts/install_claude.ps1 | iex
```

---

## ✅ Verificar

```
claude --version   # versión instalada
claude doctor      # diagnóstico de instalación, configuración y actualizaciones
```

---

## 🧹 ¿La instalación pesa mucho?

El binario es **un solo archivo (~238 MB)** — no arrastra árboles de dependencias. Con el
tiempo, el auto-update acumula versiones viejas en `~/.local/share/claude/versions/`. Libéralas:

```
./scripts/claude_cleanup.sh           # dry-run
./scripts/claude_cleanup.sh --apply   # borra las viejas, conserva la activa
```

---

## 📚 Documentación

- **Sitio (ES/EN):** https://varelaia.github.io/Claude-Installer/
- Instalación por sistema: [Linux](https://varelaia.github.io/Claude-Installer/es/linux/) ·
  [macOS](https://varelaia.github.io/Claude-Installer/es/macos/) ·
  [Windows](https://varelaia.github.io/Claude-Installer/es/windows/)
- [Preguntas frecuentes](https://varelaia.github.io/Claude-Installer/es/faq/) ·
  [Solución de problemas](https://varelaia.github.io/Claude-Installer/es/troubleshooting/)
- Documentación oficial de Anthropic: <https://code.claude.com/docs/en/setup>

---

## Licencia

[MIT](LICENSE) © 2026 Irving Varela / Varela Insights. Claude y Claude Code son marcas de
Anthropic; este es un proyecto comunitario **no afiliado** a Anthropic.
