# 卸载 Claude 右键菜单
$ErrorActionPreference = "Stop"

$regPath = "HKCU:\Software\Classes\Directory\Background\shell\OpenClaudeTerminal"
Remove-Item -Path $regPath -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Context menu uninstalled!" -ForegroundColor Yellow
