@echo off
:: 强制使用系统 cmd.exe，避免被 Cmder/ConEmu 劫持
set "COMSPEC=%SystemRoot%\System32\cmd.exe"
chcp 65001 >nul 2>&1
echo 正在添加右键菜单"打开 Claude"...

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "New-Item -Path 'HKCR:\Directory\Background\shell\OpenClaude' -Force | Out-Null; New-Item -Path 'HKCR:\Directory\Background\shell\OpenClaude\command' -Force | Out-Null; Set-ItemProperty -Path 'HKCR:\Directory\Background\shell\OpenClaude' -Name '(Default)' -Value '打开 Claude'; Set-ItemProperty -Path 'HKCR:\Directory\Background\shell\OpenClaude' -Name 'Icon' -Value 'cmd.exe'; Set-ItemProperty -Path 'HKCR:\Directory\Background\shell\OpenClaude\command' -Name '(Default)' -Value 'cmd.exe /k \"cd /d `%V && D:\nodejs\node.exe C:\Users\Administrator\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code\cli.js --dangerously-skip-permissions\"'"

if %ERRORLEVEL% EQU 0 (
    echo 安装成功！
    echo 现在可以在任意文件夹空白处右键 - "打开 Claude"
) else (
    echo 安装失败，请检查是否有管理员权限
)
pause
