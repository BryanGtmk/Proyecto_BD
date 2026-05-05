param(
    [switch]$NoBuild,
    [switch]$Logs
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectRoot

Write-Host "Iniciando Sistema Web de Gestion de Inventario Tecnologico para la FISEI..." -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker no esta instalado o no esta disponible en PATH."
}

try {
    docker info *> $null
}
catch {
    Write-Error "Docker no esta iniciado. Abre Docker Desktop y vuelve a ejecutar este script."
}

if (-not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
        Write-Host "Se creo .env desde .env.example." -ForegroundColor Yellow
    }
    else {
        Write-Error "No existe .env ni .env.example."
    }
}

if ($NoBuild) {
    docker compose up -d
}
else {
    docker compose up -d --build
}

Write-Host ""
Write-Host "Servicios iniciados:" -ForegroundColor Green
Write-Host "  Oracle DB: localhost:1521/FREEPDB1  (usar SQL Developer o SQL*Plus, no navegador)"
Write-Host "  API:      http://localhost:8080"
Write-Host "  Swagger:  http://localhost:8080/swagger"
Write-Host "  Frontend: http://localhost:5173"
Write-Host ""
Write-Host "Conexion Oracle para SQL Developer:" -ForegroundColor Cyan
Write-Host "  Usuario:     GITT_INV"
Write-Host "  Contrasena:  Gitt2026*"
Write-Host "  Host:        localhost"
Write-Host "  Puerto:      1521"
Write-Host "  Service:     FREEPDB1"
Write-Host ""
Write-Host "Si Oracle no cargo el script automaticamente, ejecuta:" -ForegroundColor Yellow
Write-Host "docker exec -it gitt-oracle-db sqlplus GITT_INV/Gitt2026*@FREEPDB1 @/container-entrypoint-initdb.d/00_bd_completa.sql"

if ($Logs) {
    docker compose logs -f
}
