# Instalador global de Commitlint + Node.js 24

Este repositorio contiene scripts para instalar:

- Node.js 24 (última versión LTS)
- commitlint global
- Un hook global de Git que valida todos los mensajes de commit en tu PC

Funciona en:
- Linux / macOS
- Windows (PowerShell)

# 🟢 ¿Qué hace este instalador?

- Instala Node.js 24
- Instala globalmente commitlint y la configuración Angular
- Crea un archivo de configuración en:
```text
~/.config/commitlint.config.js
```

Configura Git para usar un hook global commit-msg

A partir de ahora, todos tus commits se validarán automáticamente

# 🧩 Instalación
## 🟦 Linux / macOS

Copia y pega este comando:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ITEC-BCN/install-commitlint-pc/main/setup-commitlint-global.sh
)
```
## 🟪 Windows (PowerShell)

Ejecuta este comando en PowerShell:

```powershell
iwr -useb https://raw.githubusercontent.com/ITEC-BCN/install-commitlint-pc/main/setup-commitlint-global.ps1
 | iex
```


# 🔧 Para repos existentes

Si ya tienes repositorios clonados, ejecútalo dentro de cada uno:

```
git init
```

Esto aplica el hook global al repo.
