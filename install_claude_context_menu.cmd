@echo off
chcp 65001 >nul 2>&1
echo 正在添加右键菜单"打开 Claude"...

powershell.exe -NoProfile -Command ^
    "New-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude' -Force | Out-Null; ^
     Set-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude' -Name '(Default)' -Value '打开 Claude'; ^
     Set-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude' -Name 'Icon' -Value 'cmd.exe'; ^
     New-Item -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude\command' -Force | Out-Null; ^
     Set-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude\command' -Name '(Default)' -Value 'cmd.exe /k cd /d \"%%V\" && claude --dangerously-skip-permissions'"

if %ERRORLEVEL% EQU 0 (
    echo 安装成功！
    echo 现在可以在任意文件夹空白处右键 - "打开 Claude"
) else (
    echo 安装失败，请检查是否有管理员权限
)
pause
