# 修复 Claude 右键菜单 - 解决中文乱码问题
$ErrorActionPreference = "Stop"

# 删除旧项
$oldPath = "HKCU:\Software\Classes\Directory\Background\shell\OpenClaudeTerminal"
Remove-Item -Path $oldPath -Recurse -Force -ErrorAction SilentlyContinue

# 创建主项
$mainKey = "HKCU:\Software\Classes\Directory\Background\shell\OpenClaudeTerminal"
New-Item -Path $mainKey -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path $mainKey -Name "(Default)" -Value "Open Claude Here"
Set-ItemProperty -Path $mainKey -Name "Icon" -Value "wt.exe"

# 创建命令项 - 使用完整路径
$cmdKey = "HKCU:\Software\Classes\Directory\Background\shell\OpenClaudeTerminal\command"
New-Item -Path $cmdKey -Force -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path $cmdKey -Name "(Default)" -Value 'wt.exe -d "%V" claude --dangerously-skip-permissions'

Write-Host "Context menu installed successfully!" -ForegroundColor Green
Write-Host "Right-click in any folder and select 'Open Claude Here'"
