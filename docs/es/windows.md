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

## ¿Nativo o WSL? Cómo elegir

| Opción | Requiere | [Sandboxing](https://code.claude.com/docs/en/sandboxing) | Cuándo usarla |
|---|---|---|---|
| **Windows nativo** | Nada (Git para Windows es opcional) | No soportado | Proyectos y herramientas nativas de Windows |
| **WSL 2** | WSL 2 habilitado | Soportado | Toolchains Linux o ejecución de comandos en sandbox |
| **WSL 1** | WSL 1 habilitado | No soportado | Si WSL 2 no está disponible en tu equipo |

## Instalar WSL2 + Ubuntu (si todavía no lo tienes)

Requiere **Windows 10 versión 2004 (build 19041) o superior, o Windows 11**. Si tu instrucción
es "quiero la terminal de Ubuntu en Windows", este es el paso previo — instala WSL primero y
Claude Code después, dentro de esa terminal.

1. Abre **PowerShell como Administrador** (clic derecho → "Ejecutar como administrador").
2. Ejecuta:

   ```powershell
   wsl --install
   ```

   Esto habilita las características de Windows necesarias e instala **Ubuntu** como
   distribución por defecto en **WSL 2**. Para instalar otra distribución en su lugar:
   `wsl --install -d <Distro>` (lista disponibles con `wsl --list --online`).
3. **Reinicia el equipo** cuando lo pida.
4. Al reiniciar, se abre una consola de Ubuntu automáticamente. Espera a que descomprima los
   archivos y **crea tu usuario y contraseña de Linux** (son independientes de tu cuenta de
   Windows).
5. Verifica que quedó en **WSL 2**:

   ```powershell
   wsl -l -v
   ```

   La columna `VERSION` debe decir `2`. Si dice `1`, conviértela:
   `wsl --set-version Ubuntu 2`.

Con Ubuntu ya instalado, ábrelo desde el menú Inicio (o `wsl` desde PowerShell) y sigue la
sección de abajo para instalar Claude Code **dentro** de esa terminal.

!!! tip "Windows Terminal"
    Usa [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) para abrir Ubuntu en
    pestañas, con perfiles y atajos configurables — es la forma recomendada de trabajar con WSL.

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
