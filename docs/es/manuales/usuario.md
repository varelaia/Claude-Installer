---
title: "Manual de usuario — Claude Code"
description: "Guía sencilla para empezar con Claude Code: instalar, iniciar sesión, primeros pasos y comandos básicos."
---

# Manual de usuario

Guía sencilla para instalar y empezar a usar **Claude Code**, sin tecnicismos.

## 1. Instalar (un comando)

Abre tu terminal y pega el comando de tu sistema:

- **Mac / Linux:** `curl -fsSL https://claude.ai/install.sh | bash`
- **Windows (PowerShell):** `irm https://claude.ai/install.ps1 | iex`

Cuando termine, **cierra y abre una terminal nueva**.

## 2. Comprobar que quedó

```bash
claude --version
```

Debe imprimir un número de versión. Si dice "command not found", abre una terminal nueva o
revisa la [Solución de problemas](../troubleshooting.md).

## 3. Iniciar sesión

Entra a la carpeta de tu proyecto y escribe:

```bash
claude
```

La primera vez se abre el **navegador** para iniciar sesión con tu cuenta de Claude
(**Pro, Max, Team o Enterprise** — el plan gratuito no incluye Claude Code). Acepta y listo.

## 4. Usarlo

Ya dentro, Claude Code funciona como un chat en tu terminal que además puede **leer y editar
tu código** y **ejecutar comandos** en tu proyecto. Escribe lo que necesitas en lenguaje
natural, por ejemplo:

- *"Explícame qué hace este proyecto."*
- *"Arregla el error de la función de login."*
- *"Agrega pruebas a este archivo."*

Comandos útiles dentro de la sesión:

- `/login` — volver a iniciar sesión.
- `/help` — ver la ayuda.
- Para **salir**: `Ctrl + C` o escribe `/exit`.

## 5. Si algo no funciona

- Abre una terminal **nueva** y vuelve a probar `claude --version`.
- En Mac, verifica que tengas **macOS 13 o superior** (`sw_vers`).
- Revisa la [Solución de problemas](../troubleshooting.md).
