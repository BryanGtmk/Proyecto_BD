param(
    [switch]$Volumes
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot

Write-Host "Deteniendo servicios del proyecto..." -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker no esta instalado o no esta disponible en PATH."
}

if ($Volumes) {
    Write-Host "Se eliminaran tambien los volumenes, incluida la data de Oracle." -ForegroundColor Yellow
    docker compose down -v
}
else {
    docker compose down
}

Write-Host "Servicios detenidos." -ForegroundColor Green
