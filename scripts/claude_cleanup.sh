#!/usr/bin/env bash
# claude_cleanup.sh — Libera espacio borrando versiones VIEJAS de Claude Code.
#
# Por qué existe: el auto-update de Claude Code deja las versiones anteriores en
# ~/.local/share/claude/versions/ (cada binario ~238 MB). Con el tiempo eso crece
# (ej. 900+ MB). Este script conserva SOLO la versión activa (a la que apunta el
# symlink ~/.local/bin/claude) y borra las demás. Es seguro: nunca toca la actual.
#
# Uso:
#   claude_cleanup.sh            # muestra qué borraría (dry-run, no borra nada)
#   claude_cleanup.sh --apply    # borra de verdad las versiones viejas
set -euo pipefail

VERSIONS_DIR="${CLAUDE_DATA_DIR:-$HOME/.local/share/claude}/versions"
LINK="$HOME/.local/bin/claude"
APPLY=0
[ "${1:-}" = "--apply" ] && APPLY=1

if [ ! -d "$VERSIONS_DIR" ]; then
    echo "No encontré $VERSIONS_DIR — ¿Claude Code instalado con el instalador nativo?" >&2
    exit 1
fi

# Versión activa = destino del symlink (basename), si existe.
CURRENT=""
if [ -L "$LINK" ]; then
    CURRENT="$(basename "$(readlink -f "$LINK")")"
fi

echo "Directorio de versiones: $VERSIONS_DIR"
echo "Versión activa:          ${CURRENT:-'(no detectada — no se borrará nada por seguridad)'}"
echo "Uso actual:              $(du -sh "$VERSIONS_DIR" 2>/dev/null | cut -f1)"
echo ""

if [ -z "$CURRENT" ]; then
    echo "⚠ No pude detectar la versión activa vía $LINK. Aborto para no borrar la que usas." >&2
    exit 1
fi

# Listar versiones viejas (todo menos la actual).
mapfile -t OLD < <(find "$VERSIONS_DIR" -mindepth 1 -maxdepth 1 -not -name "$CURRENT" 2>/dev/null | sort)

if [ "${#OLD[@]}" -eq 0 ]; then
    echo "✓ No hay versiones viejas que borrar. Todo limpio."
    exit 0
fi

echo "Versiones viejas a borrar (${#OLD[@]}):"
for v in "${OLD[@]}"; do
    printf '  %s  (%s)\n' "$(basename "$v")" "$(du -sh "$v" 2>/dev/null | cut -f1)"
done
echo ""

if [ "$APPLY" -ne 1 ]; then
    echo "▶ Esto es un dry-run. Para borrarlas de verdad, corre:  $0 --apply"
    exit 0
fi

for v in "${OLD[@]}"; do
    rm -rf -- "$v"
done
echo "✓ Borradas ${#OLD[@]} versión(es) vieja(s)."
echo "Uso nuevo:               $(du -sh "$VERSIONS_DIR" 2>/dev/null | cut -f1)"
