#!/usr/bin/env bash
set -e

echo "=== Instalando Node.js 24 con nvm ==="

# Instalar nvm si no existe
if ! command -v nvm &> /dev/null; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Instalar Node 24 LTS
nvm install 24
nvm use 24
nvm alias default 24

echo "Node versión instalada:"
node -v

echo "=== Instalando commitlint globalmente ==="
npm install -g @commitlint/cli @commitlint/config-angular

echo "=== Creando archivo de configuración global ==="
mkdir -p ~/.config
cat << 'EOF' > ~/.config/commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-angular']
};
EOF

echo "=== Configurando plantilla global de Git ==="
mkdir -p ~/.git-templates/hooks
git config --global init.templatedir "~/.git-templates"

echo "=== Creando hook global commit-msg ==="
cat << 'EOF' > ~/.git-templates/hooks/commit-msg
#!/bin/sh
commitlint --config ~/.config/commitlint.config.js --edit "$1"
EOF
chmod +x ~/.git-templates/hooks/commit-msg

echo "=== Instalación completada ==="
echo "Para repos existentes:  git init"
