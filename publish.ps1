# PowerShell: 在解压后的项目根目录执行
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
$repo = 'vicuncle/weike-software-website'
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '未找到 Git，请先安装 Git。' }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw '未找到 GitHub CLI (gh)，请先安装 https://cli.github.com/。' }
gh auth status *> $null
if ($LASTEXITCODE -ne 0) { gh auth login; if ($LASTEXITCODE -ne 0) { throw 'GitHub 登录未完成。' } }
if (-not (Test-Path '.git')) { git init -b main; if ($LASTEXITCODE -ne 0) { throw 'Git 初始化失败。' } }
git add .
if ($LASTEXITCODE -ne 0) { throw '添加文件失败。' }
$pending = git status --porcelain
if ($pending) {
  git commit -m 'feat: initialize Weike Software website'
  if ($LASTEXITCODE -ne 0) { throw 'Git 提交失败：请先配置 git config user.name 和 user.email。' }
}
$branch = (git branch --show-current).Trim()
if ($branch -ne 'main') { git branch -M main }
$exists = gh repo view $repo --json name *> $null
if ($LASTEXITCODE -eq 0) {
  $origin = git remote
  if (-not ($origin -contains 'origin')) { git remote add origin "https://github.com/$repo.git" }
  else { git remote set-url origin "https://github.com/$repo.git" }
  git push -u origin main
  if ($LASTEXITCODE -ne 0) { throw '推送失败，请检查 GitHub 仓库权限。' }
} else {
  gh repo create $repo --public --source . --remote origin --push --description '维克软件官网 · 企业软件开发与 AI 应用服务'
  if ($LASTEXITCODE -ne 0) { throw '创建或推送仓库失败，请检查 GitHub 授权。' }
}
Write-Host '成功：https://github.com/vicuncle/weike-software-website' -ForegroundColor Green
Write-Host '接下来打开 https://vercel.com/new 导入此仓库。'
