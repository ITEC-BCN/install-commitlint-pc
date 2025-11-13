# Installing commitlint on ITB PCs

### ⚠️ **IMPORTANT**: The institute's PCs come with Node 12 and Node 18 is required to work.

## Install Node 24
Node 24 is the latest LTS version to date, we will install it from `fnm`
```bash
# Install fnm
curl -o- https://fnm.vercel.app/install | bash
# Restart path
source ~/.bashrc
# Install Node 24
fnm install 24 # Change the version if desired
# Check that it works
node -v
npm -v
```

## Installing commitlint
In our current repository we will install husky and commitlint to check commits:
```bash
# Initialize node
npm init -y
# Install dependencies with node
npm install -D @commitlint/cli @commitlint/config-conventional
# Configure initial commitlint
echo "export default { extends: ['@commitlint/config-conventional'] };" > commitlint.config.mjs
# Configure husky
npx husky init
# Remove default husky file
rm .husky/pre-commit
# Configure commitlint
echo "npx --no -- commitlint --edit \$1" > .husky/commit-msg
```
**NOTE**: If the file is not created, create a file at `.husky/commit-msg` and put `npx --no -- commitlint --edit \$1`.

## Check functionality
To test if it works we will make an empty commit that fails and another that succeeds

### Failure test
```bash
git commit -am "failure test"
```
Expected result:
```text
⧗   input: failure test
✖   Please add rules to your `commitlint.config.js`
    - Getting started guide: https://commitlint.js.org/guides/getting-started
    - Example config: https://github.com/conventional-changelog/commitlint/blob/master/%40commitlint/config-conventional/src/index.ts [empty-rules]

✖   found 1 problems, 0 warnings
ⓘ   Get help: https://github.com/conventional-changelog/commitlint/#what-is-commitlint

husky - commit-msg script failed (code 9)
```

### Correct test
```bash
git commit -m "feat: added readmes"
```

Result:
```bash
[master af9846c] feat: added readmes
 7 files changed, 1279 insertions(+)
```