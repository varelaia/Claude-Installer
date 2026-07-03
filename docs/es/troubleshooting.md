---
title: "Solución de problemas de Claude Code"
description: "Errores comunes al instalar Claude Code y cómo resolverlos: command not found, PATH, permisos npm, macOS 13, Windows execution policy, WSL, login."
---

# Solución de problemas

## `claude: command not found` / `claude no se reconoce`

Si el instalador dijo "instalación completa", el binario **sí se instaló**; lo que falla es el
`PATH` (la terminal aún no lo encuentra). **No reinstales** — es un problema de ruta, no de
instalación.

!!! tip "Dónde queda el binario (dato exacto — no adivines)"
    El instalador nativo deja `claude` en **`~/.local/bin/claude`** (un symlink →
    `~/.local/share/claude/versions/<versión>`). **NO** está en `~/.claude/bin` ni en
    `/usr/local/bin`. `~/.claude/` es la *configuración*, no el binario. En Windows:
    `%USERPROFILE%\.local\bin\claude.exe`.

**Diagnóstico correcto (en orden):**

=== "Linux / macOS"

    ```bash
    # 1) ¿Existe el binario? — este es el check AUTORITATIVO
    ls -l ~/.local/bin/claude
    # 2) ¿Corre por ruta absoluta? Si imprime versión → está instalado, es solo PATH:
    ~/.local/bin/claude --version
    # 3) Arregla el PATH en el archivo que TU shell lee (ver aviso de abajo) y recarga.
    #    Ejemplo zsh (macOS moderno):
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    ```

=== "Windows"

    Abre una terminal **nueva** (el PATH no se actualiza en la sesión actual). Si sigue sin
    reconocerse, revisa que `%USERPROFILE%\.local\bin` esté en el PATH de usuario.

!!! danger "NO concluyas 'no se instaló' si `which claude` no devuelve nada"
    Un `which claude` vacío, o un `find ~/.claude ...` que no encuentra nada, **NO** significa
    que la instalación falló — casi siempre significa que **buscaste en el lugar equivocado**.
    El binario está en **`~/.local/bin/claude`**. Comprueba SIEMPRE con
    `ls -l ~/.local/bin/claude` (o corre `~/.local/bin/claude --version`), **nunca** deduzcas
    "no instalado" desde un `which`/`find` en otras rutas.

!!! warning "El archivo de PATH depende de TU shell — no todos usan `~/.bashrc`"
    Averigua tu shell con `echo $SHELL` y usa el archivo correcto:

    - **macOS con zsh** (default moderno; el prompt termina en `%`) → `~/.zshrc`.
    - **macOS con bash** (el prompt termina en `$`) → **`~/.bash_profile`**. Un login shell bash
      en macOS **no** lee `~/.bashrc` → por eso `source ~/.bashrc` da error o "no hace nada".
    - **Linux** → normalmente `~/.bashrc`.

!!! info "Por qué pasa"
    Un script no puede cambiar el `PATH` de la terminal que lo invocó. Siempre necesitas una
    **terminal nueva** o `source` tras instalar.

## `claude --version` no imprime nada / se queda igual

Casi siempre es PATH: estás invocando un `claude` que no existe en esta sesión. Prueba con la
ruta absoluta:

```bash
~/.local/bin/claude --version
```

Si con ruta absoluta sí imprime, es PATH (ver arriba).

## macOS: requiere macOS 13.0 (Ventura) o superior

Claude Code no soporta versiones anteriores de macOS. Verifica con `sw_vers`; si
`ProductVersion` es menor a 13.0, actualiza macOS o usa un Mac más nuevo.

## npm: `EACCES: permission denied`

El directorio global de npm no es escribible. **No uses `sudo`** (causa problemas de permisos
y seguridad). Configura un prefijo de usuario:

```bash
mkdir ~/.npm-global
npm config set prefix ~/.npm-global
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc   # o ~/.zshrc
```

Mejor aún: usa el **instalador nativo**, que no depende de npm.

## `curl: (403)` o `syntax error near unexpected token '<'`

Suele ser un proxy/firewall que devuelve HTML en vez del script. Revisa tu red/proxy y
reintenta; si persiste, prueba otro método (npm, Homebrew) o consulta la guía oficial de
[solución de problemas de instalación](https://code.claude.com/docs/en/troubleshoot-install).

## Windows: el script de PowerShell no corre (execution policy)

Ejecuta en la misma consola, sin admin:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```

y vuelve a lanzar el comando. Asegúrate de estar en **PowerShell** (no CMD).

## No puedo iniciar sesión / "no incluido en tu plan"

Claude Code **no** funciona con el plan gratuito de Claude.ai. Necesitas **Pro, Max, Team o
Enterprise**, o una cuenta de **Console** con API. Dentro de una sesión, reautentícate con
`/login`.

## Instalé en un servidor / por SSH y no abre el navegador

En un VPS o sesión SSH sin interfaz gráfica, el login no puede abrir un navegador. Claude Code te
muestra una **URL y un código**: cópialos, ábrelos en el navegador de **tu máquina local**,
autoriza y vuelve a la terminal. Si el proceso se queda colgado en *Signing in…*, fuerza el flujo
por terminal:

```bash
unset DISPLAY && claude
```

## Error de red / "region not supported"

Claude Code no está disponible en todos los países. Revisa la lista de
[países soportados por Anthropic](https://www.anthropic.com/supported-countries). Si tu región sí
aplica, suele ser un proxy/firewall: prueba otra red o consulta la
[guía oficial de instalación](https://code.claude.com/docs/en/troubleshoot-install).

## La carpeta de Claude creció mucho (cientos de MB)

El auto-update conserva versiones viejas en `~/.local/share/claude/versions/`. Libéralas
dejando solo la activa:

```bash
# dry-run (muestra qué borraría):
./scripts/claude_cleanup.sh
# borrar de verdad:
./scripts/claude_cleanup.sh --apply
```

## `claude` sigue apareciendo tras desinstalar

Hay una instalación conflictiva (varias copias o un alias). Búscalas:

```bash
which -a claude
```

y elimina la sobrante o el alias en tu perfil de shell.

---

¿Tu caso no está aquí? Abre un *issue* en
[GitHub](https://github.com/varelaia/Claude-Installer/issues) o consulta la
[documentación oficial](https://code.claude.com/docs/en/troubleshoot-install).
