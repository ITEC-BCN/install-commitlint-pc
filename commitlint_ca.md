# Instal·lació de commitlint en PCs ITB

### ⚠️ **IMPORTANT**: Els PCs de l'institut vénen amb Node 12 i es necessita Node 18 per funcionar.

## Instal·lar Node 24
Node 24 és l'última versió LTS fins a la data, la instal·larem des de `fnm`
```bash
# Instal·lar fnm
curl -o- https://fnm.vercel.app/install | bash
# Reiniciar path
source ~/.bashrc
# Instal·lar Node 24
fnm install 24 # Si es vol es canvia la versió
# Comprovar que funciona
node -v
npm -v
```

## Instal·lació de commitlint
Al nostre repositori actual instal·larem husky i commitlint per comprovar els commits:
```bash
# Inicialitzar node
npm init -y
# Instal·lar dependències amb node
npm install -D @commitlint/cli @commitlint/config-conventional
# Configurar commitlint inicial
echo "export default { extends: ['@commitlint/config-conventional'] };" > commitlint.config.mjs
# Configurar husky
npx husky init
# Eliminar arxiu predefinit de husky
rm .husky/pre-commit
# Configurar commitlint
echo "npx --no -- commitlint --edit \$1" > .husky/commit-msg
```
**NOTA**: Si no crea l'arxiu, crear arxiu a `.husky/commit-msg` i posar `npx --no -- commitlint --edit \$1`.

## Comprovar funcionament
Per provar si funciona farem un commit buit que falli i un altre que surti bé

### Prova de fallada
```bash
git commit -am "prova de fallada"
```
Resultat esperat:
```text
⧗   input: prova de fallada
✖   Please add rules to your `commitlint.config.js`
    - Getting started guide: https://commitlint.js.org/guides/getting-started
    - Example config: https://github.com/conventional-changelog/commitlint/blob/master/%40commitlint/config-conventional/src/index.ts [empty-rules]

✖   found 1 problems, 0 warnings
ⓘ   Get help: https://github.com/conventional-changelog/commitlint/#what-is-commitlint

husky - commit-msg script failed (code 9)
```

### Prova correcta
```bash
git commit -m "feat: added readmes"
```

Resultat:
```bash
[master af9846c] feat: added readmes
 7 files changed, 1279 insertions(+)
```