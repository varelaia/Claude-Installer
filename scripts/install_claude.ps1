# install_claude.ps1 — Wrapper del instalador OFICIAL de Claude Code (Anthropic) en Windows.
#
# Filosofía (igual que el repo antigravity-installer): NO reimplementamos la descarga.
# El instalador oficial baja UN binario nativo autocontenido a %USERPROFILE%\.local\bin,
# NO necesita Node.js, y se auto-actualiza. Este wrapper solo delega en el oficial y
# asegura el PATH de usuario. No requiere permisos de administrador.
#
# Instalación mínima por diseño: solo claude.exe. Sin suites de herramientas.

$ErrorActionPreference = "Stop"
$BinDir  = Join-Path $env:USERPROFILE ".local\bin"
$BinPath = Join-Path $BinDir "claude.exe"

Write-Host "=== Instalador Claude Code para Windows ===" -ForegroundColor Cyan

# 1) Idempotencia: si ya existe, no reinstalar (se auto-actualiza solo).
if (Test-Path $BinPath) {
    Write-Host "✓ 'claude.exe' ya está instalado en $BinPath (se auto-actualiza en background)." -ForegroundColor Green
} else {
    Write-Host "⬇ Ejecutando el instalador oficial de Claude Code..." -ForegroundColor Yellow
    Invoke-RestMethod -Uri "https://claude.ai/install.ps1" | Invoke-Expression
}

# 2) Persistir el PATH de USUARIO de forma idempotente (red de seguridad).
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$BinDir*") {
    $newPath = if ([string]::IsNullOrEmpty($userPath)) { $BinDir } else { "$userPath;$BinDir" }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "✓ Añadido $BinDir al PATH de usuario." -ForegroundColor Green
} else {
    Write-Host "✓ $BinDir ya estaba en el PATH de usuario." -ForegroundColor Green
}
# Cargar en la sesión actual de PowerShell.
$env:Path = "$env:Path;$BinDir"

# 3) Verificar.
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "`n=== ✅ Claude Code lista ===" -ForegroundColor Green
    Write-Host "Versión: $(claude --version)"
    Write-Host "`n▶ Para empezar: abre una terminal NUEVA, entra a un proyecto y ejecuta:  claude" -ForegroundColor Cyan
    Write-Host "  La primera vez se abrirá el navegador para iniciar sesión (Pro/Max/Team/Enterprise o Console API)."
    Write-Host "  Diagnóstico:  claude doctor"
} else {
    Write-Host "✗ 'claude' no quedó en el PATH. Abre una terminal NUEVA de PowerShell." -ForegroundColor Red
    exit 1
}
