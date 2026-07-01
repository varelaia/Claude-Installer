#!/usr/bin/env bash
# install_claude.sh — Wrapper del instalador OFICIAL de Claude Code (Anthropic)
# para Linux y macOS.
#
# Filosofía (igual que el repo antigravity-installer): NO reimplementamos la descarga.
# El instalador oficial baja UN binario nativo autocontenido (~238 MB) a ~/.local/bin,
# no necesita Node.js ni Homebrew ni build-tools, y se auto-actualiza. Este wrapper solo
# añade lo poco que conviene: verificar la versión de macOS (Claude Code pide 13+),
# asegurar el PATH de forma idempotente y verificar el resultado.
#
# Instalación mínima por diseño: solo el binario claude. Sin suites de herramientas.
set -euo pipefail

OFFICIAL_URL="https://claude.ai/install.sh"
BIN_DIR="${CLAUDE_BIN_DIR:-$HOME/.local/bin}"
PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'

say() { printf '%s\n' "$*"; }

# 0) Pre-flight macOS: Claude Code requiere macOS 13.0 (Ventura)+.
#    (Solo aplica a macOS; en Linux no se evalúa.)
if [ "$(uname -s)" = "Darwin" ]; then
    OS_VER="$(sw_vers -productVersion 2>/dev/null || echo 0)"
    OS_MAJOR="${OS_VER%%.*}"
    if ! printf '%s' "$OS_MAJOR" | grep -qE '^[0-9]+$' || [ "$OS_MAJOR" -lt 13 ]; then
        {
            say "✗ macOS ${OS_VER} NO cumple el requisito de Claude Code."
            say "  Claude Code requiere macOS 13.0 (Ventura) o superior."
            say "  Actualiza macOS (Ajustes → Actualización de software) o usa un Mac más nuevo."
        } >&2
        exit 1
    fi
    echo "✓ macOS ${OS_VER} (>= 13.0)."
fi

# 1) Requisito mínimo del instalador oficial: curl o wget.
if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
    say "✗ Necesitas 'curl' o 'wget' instalado." >&2
    exit 1
fi

# 2) Ejecutar el instalador oficial (idempotente; el binario se auto-actualiza solo).
if command -v claude >/dev/null 2>&1 || [ -x "$BIN_DIR/claude" ]; then
    say "✓ 'claude' ya está instalado ($(command -v claude 2>/dev/null || echo "$BIN_DIR/claude"))."
    say "  Claude Code se auto-actualiza en segundo plano; no hace falta reinstalar."
    say "  (Para forzar una reinstalación limpia, borra ~/.local/bin/claude y ~/.local/share/claude.)"
else
    say "⬇ Ejecutando el instalador oficial de Claude Code…"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$OFFICIAL_URL" | bash
    else
        wget -qO- "$OFFICIAL_URL" | bash
    fi
fi

# 3) Persistir el PATH de forma idempotente (red de seguridad; el instalador oficial
#    ya lo hace, pero gateamos por si la línea NO está en el perfil correcto de tu shell).
case "$(basename "${SHELL:-bash}")" in
    zsh)  PROFILE="$HOME/.zshrc" ;;
    bash) PROFILE="$HOME/.bashrc" ;;
    *)    PROFILE="$HOME/.profile" ;;
esac
touch "$PROFILE"
if ! grep -qsF "$PATH_LINE" "$PROFILE"; then
    printf '\n# Claude Code\n%s\n' "$PATH_LINE" >> "$PROFILE"
    say "✓ Añadido \$HOME/.local/bin al PATH en $PROFILE"
else
    say "✓ \$HOME/.local/bin ya estaba en $PROFILE"
fi

# 4) Cargar en la sesión actual (solo este subshell) y verificar.
export PATH="$BIN_DIR:$PATH"
if command -v claude >/dev/null 2>&1; then
    say ""
    say "=== ✅ Claude Code lista ==="
    say "Ruta:    $(command -v claude)"
    say "Versión: $(claude --version 2>/dev/null || echo '(ejecuta: claude --version)')"
    say ""
    say "▶ Para empezar:  abre una terminal NUEVA (o 'source $PROFILE'), entra a un proyecto y ejecuta:  claude"
    say "  La primera vez se abrirá el navegador para iniciar sesión (Pro/Max/Team/Enterprise o Console API)."
    say "  Diagnóstico:  claude doctor"
else
    say "✗ 'claude' no quedó en el PATH. Ejecuta:  source $PROFILE" >&2
    exit 1
fi
