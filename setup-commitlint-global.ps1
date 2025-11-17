# ============================================
# Setup Node 24 + commitlint + git global hook
# ============================================

Write-Host "=== Instalando Node.js 24 usando winget ==="

# Intenta instalar Node 24 LTS
winget install OpenJS.NodeJS.LTS -e --silent --accept-source-agreements --accept-package-agreements

# Añadir Node al PATH temporalmente para esta sesión
$NodePath = "C:\Program Files\nodejs"
if (Test-Path $NodePath) {
    $env:PATH = "$NodePath;$env:PATH"
} else {
    Write-Warning "No se encontró Node en $NodePath. Comprueba la instalación."
}

Write-Host "Versión de Node instalada:"
node -v
npm -v

Write-Host "=== Instalando commitlint globalmente ==="
npm install -g @commitlint/cli @commitlint/config-angular

Write-Host "=== Creando directorio de configuración ==="
$ConfigDir = "$HOME\.config"
if (!(Test-Path $ConfigDir)) {
    New-Item -Type Directory -Path $ConfigDir | Out-Null
}

Write-Host "=== Creando archivo de configuración ==="
$ConfigFile = "$ConfigDir\commitlint.config.js"
@"
module.exports = {
  extends: ['@commitlint/config-angular']
};
"@ | Set-Content $ConfigFile -Encoding UTF8

Write-Host "=== Configurando plantilla global de Git ==="
$TemplateDir = "$HOME\.git-templates\hooks"
if (!(Test-Path $TemplateDir)) {
    New-Item -Type Directory -Path $TemplateDir -Force | Out-Null
}
git config --global init.templatedir "$HOME\.git-templates"

Write-Host "=== Creando hook global commit-msg ==="
$HookFile = "$TemplateDir\commit-msg"
@"
commitlint --config "$HOME/.config/commitlint.config.js" --edit "\$1"
"@ | Set-Content $HookFile -Encoding ASCII

Write-Host "=== Instalación completada ==="
Write-Host "Para repos existentes: git init"
