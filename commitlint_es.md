# Instalación de commitlint en PCs ITB

### ⚠️ **IMPORTANTE**: Los PCs del instituto vienen con Node 12 y se necesita Node 18 para funcionar.

## Instalar Node 24
Node 24 es la última versión LTS hasta la fecha, la instalaremos desde `fnm`
```bash
# Instalar fnm
curl -o- https://fnm.vercel.app/install | bash
# Reiniciar path
source ~/.bashrc
# Instalar Node 24
fnm install 24 # Si se quiere se cambia la versión
# Comprobar que funciona
node -v
npm -v
```

## Instalación de commitlint
En nuestro repositorio actual instalaremos husky y commitlint para comprobar los commits:
```bash
# Inicializar node
npm init -y
# Instalar dependencias con node
npm install -D @commitlint/cli @commitlint/config-conventional
# Configurar commitlint inicial
echo "export default { extends: ['@commitlint/config-conventional'] };" > commitlint.config.mjs
# Configurar husky
npx husky init
# Eliminar archivo predefinido de husky
rm .husky/pre-commit
# Configurar commitlint
echo "npx --no -- commitlint --edit \$1" > .husky/commit-msg
```
**NOTA**: Si no crea el archivo, crear archivo en `.husky/commit-msg` y poner `npx --no -- commitlint --edit \$1`.

## Comprobar funcionamiento
Para probar si funciona haremos un commit vacío que falle y otro que salga bien

### Prueba de fallo
```bash
git commit -am "prueba de fallo"
```
Resultado esperado:
```text
⧗   input: prueba de fallo
✖   Please add rules to your `commitlint.config.js`
    - Getting started guide: https://commitlint.js.org/guides/getting-started
    - Example config: https://github.com/conventional-changelog/commitlint/blob/master/%40commitlint/config-conventional/src/index.ts [empty-rules]

✖   found 1 problems, 0 warnings
ⓘ   Get help: https://github.com/conventional-changelog/commitlint/#what-is-commitlint

husky - commit-msg script failed (code 9)
```

### Prueba correcta
```bash
git commit -m "feat: added readmes"
```

Resultado:
```bash
[master af9846c] feat: added readmes
 7 files changed, 1279 insertions(+)
```