# Claude Code — Instalador y Guía Completa

> **📖 Documentación completa (sitio): https://varelaia.github.io/Claude-Installer/**

Guía paso a paso, scripts y manuales para instalar **Claude Code** — el CLI de **Anthropic**
para programar con Claude en tu terminal — en **Linux**, **macOS** y **Windows**, sin permisos
de administrador.

El instalador nativo baja **un binario autocontenido** (varios cientos de MB) a `~/.local/bin`,
**no usa Node.js** y se auto-actualiza. Instalación **mínima por diseño**: solo el binario
`claude`, sin suites de herramientas ni dependencias arrastradas.

---

## ⚡ Instalación rápida (instalador nativo — recomendado)

**Linux / macOS / WSL**

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
> este repo abortan solos si detectan una versión menor.

> [!NOTE]
> **El plan gratuito de Claude.ai NO incluye Claude Code.** Necesitas suscripción **Pro, Max,
> Team o Enterprise**, o una cuenta de **Console** con acceso a la API.

> [!NOTE]
> **¿Usas WSL (Windows Subsystem for Linux)?** Dentro de WSL eres Linux: usa el one-liner de
> **Linux**, no el de Windows.

---

## 📦 Requisitos

| Sistema | Requisito |
|---|---|
| **Linux** (incluido **WSL 2**) | Ubuntu 20.04+/Debian 10+, 4 GB RAM, x64 o ARM64 |
| **macOS** | **macOS 13.0 (Ventura)+**, 4 GB RAM |
| **Windows nativo** | Windows 10 1809+ |
| **Node.js** | **Solo** para el método `npm` (Node 18+). El instalador nativo no lo necesita. |

---

## 🔀 Otras formas de instalar (y cuándo usarlas)

| Método | Cuándo elegirlo |
|---|---|
| **Instalador nativo** *(recomendado)* | Por defecto — un binario, sin dependencias, auto-update. |
| `npm install -g @anthropic-ai/claude-code` | Si ya vives en el ecosistema Node (requiere Node 18+). |
| `brew install --cask claude-code` | Si gestionas todo con Homebrew (macOS/Linux). Update manual. |
| `winget install Anthropic.ClaudeCode` | Windows corporativo con winget. |

⚠️ **No uses `sudo npm install -g`** (rompe permisos). Si npm global no es escribible, usa un
prefijo de usuario **y añádelo al PATH**:

```bash
mkdir ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc   # o ~/.zshrc en macOS
source ~/.bashrc
```

Mejor aún: el instalador nativo evita todo esto.

---

## 🛠️ Scripts de este repo

| Script | Plataforma | Qué hace |
|---|---|---|
| `scripts/install_claude.sh` | Linux / macOS | Ejecuta el instalador oficial + verifica **macOS 13+** + persiste `~/.local/bin` en el PATH + verifica |
| `scripts/install_claude.ps1` | Windows | Ejecuta el instalador oficial + persiste el PATH de usuario + verifica |
| `scripts/claude_cleanup.sh` | Linux / macOS | **Anti-bloat**: borra versiones viejas acumuladas por el auto-update (`~/.local/share/claude/versions/`), conserva la activa. Dry-run por defecto; `--apply` para borrar |

One-liners (sin clonar):

```
# Linux / macOS / WSL
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

El binario es **un solo archivo** — no arrastra árboles de dependencias. Con el tiempo, el
auto-update acumula versiones viejas en `~/.local/share/claude/versions/`. Libéralas:

```
./scripts/claude_cleanup.sh           # dry-run
./scripts/claude_cleanup.sh --apply   # borra las viejas, conserva la activa
```

---

## 🆘 Problemas frecuentes

<details>
<summary><b>claude: command not found</b> tras instalar</summary>

El binario se instaló pero tu terminal no recargó el PATH. **Abre una terminal nueva**, o:

```bash
source ~/.bashrc        # Linux / WSL      ·  en macOS con zsh: source ~/.zshrc
```

Confirma con la ruta absoluta: `~/.local/bin/claude --version`.
</details>

<details>
<summary><b>macOS: sigue diciendo <i>command not found</i></b></summary>

macOS moderno usa **zsh**, que **no lee `~/.bashrc`**. Si el PATH fue a `.bashrc`, ponlo en
`~/.zshrc`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```
</details>

<details>
<summary><b>Instalé en un servidor / por SSH y no abre el navegador</b></summary>

En un VPS o sesión SSH sin interfaz gráfica, el login no puede abrir el navegador. Claude Code te
muestra una **URL y un código**: cópialos, ábrelos en el navegador de **tu máquina local**,
autoriza y vuelve. Si se cuelga en *Signing in…*, fuerza el flujo por terminal:

```bash
unset DISPLAY && claude
```
</details>

<details>
<summary><b>El auto-update falla: <i>no write permission to npm prefix</i></b></summary>

Pasa si instalaste con `sudo npm` o un prefijo del sistema. La salida limpia es **migrar al
instalador nativo** (no depende de npm):

```bash
rm -f ~/.local/bin/claude && curl -fsSL https://claude.ai/install.sh | bash
```

Alternativa: mover el prefix de npm a user-space (ver *Otras formas de instalar*).
</details>

<details>
<summary><b>Error de red / <i>region not supported</i></b></summary>

Claude Code no está disponible en todos los países. Revisa la lista de
[países soportados por Anthropic](https://www.anthropic.com/supported-countries). Si tu región sí
aplica, suele ser proxy/firewall: prueba otra red o la
[guía oficial](https://code.claude.com/docs/en/troubleshoot-install).
</details>

<details>
<summary><b>No puedo iniciar sesión / <i>not included in your plan</i></b></summary>

El plan **gratuito** de Claude.ai no incluye Claude Code. Necesitas **Pro, Max, Team o
Enterprise**, o una cuenta de **Console** con API. Dentro de una sesión: `/login`.
</details>

Más casos en la [solución de problemas del sitio](https://varelaia.github.io/Claude-Installer/troubleshooting/).

---

## 📚 Documentación

- **Sitio (ES/EN):** https://varelaia.github.io/Claude-Installer/
- Instalación por sistema: [Linux](https://varelaia.github.io/Claude-Installer/linux/) ·
  [macOS](https://varelaia.github.io/Claude-Installer/macos/) ·
  [Windows](https://varelaia.github.io/Claude-Installer/windows/)
- [Preguntas frecuentes](https://varelaia.github.io/Claude-Installer/faq/) ·
  [Solución de problemas](https://varelaia.github.io/Claude-Installer/troubleshooting/)
- Documentación oficial de Anthropic: <https://code.claude.com/docs/en/setup>

---

## Licencia

[MIT](LICENSE) © 2026 Irving Varela / Varela Insights. Claude y Claude Code son marcas de
Anthropic; este es un proyecto comunitario **no afiliado** a Anthropic.
