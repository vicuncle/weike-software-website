#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
REPO='vicuncle/weike-software-website'
command -v git >/dev/null || { echo '请先安装 Git'; exit 1; }
command -v gh >/dev/null || { echo '请先安装 GitHub CLI: https://cli.github.com/'; exit 1; }
gh auth status >/dev/null 2>&1 || gh auth login
if [ ! -d .git ]; then git init -b main; fi
git add .
if [ -n "$(git status --porcelain)" ]; then git commit -m 'feat: initialize Weike Software website'; fi
git branch -M main
if gh repo view "$REPO" >/dev/null 2>&1; then
  if git remote get-url origin >/dev/null 2>&1; then git remote set-url origin "https://github.com/$REPO.git"; else git remote add origin "https://github.com/$REPO.git"; fi
  git push -u origin main
else
  gh repo create "$REPO" --public --source . --remote origin --push --description 'Weike Software official website'
fi
echo "GitHub 仓库：https://github.com/$REPO"
echo '下一步：https://vercel.com/new'
